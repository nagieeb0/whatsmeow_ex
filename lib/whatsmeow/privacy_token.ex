defmodule Whatsmeow.PrivacyToken do
  @moduledoc """
  Trusted-contact ("tctoken") privacy tokens — the anti-spam gate on 1:1 sends.

  Ports `whatsmeow-main/tctoken.go` plus the tctoken branches of `send.go`
  (`sendDM`) and `notification.go` (`handlePrivacyTokenNotification`).

  ## Why this exists

  WhatsApp gates a linked device's messages to a contact behind a token the
  server issues on our behalf. Send a 1:1 message without attaching a token the
  recipient trusts and the stanza is **accepted by the socket** — we get an
  `<ack class="message">` and everything looks fine — but the application layer
  rejects it with error **463** (`MessageAccountRestriction`) and the message is
  never delivered. This is the classic "my sends succeed but nothing arrives"
  failure, and it is invisible unless you inspect the ack.

  Two halves, both driven from `Whatsmeow.Send`:

    1. **Attach** — if `fetch/2` finds an unexpired token for the recipient,
       `Whatsmeow.Send` adds it as a `<tctoken>` child of the outgoing
       `<message>`.
    2. **Issue** — after a 1:1 send, `issue_async/3` fires a `privacy` IQ asking
       the server to vouch for us. The token it hands back arrives later as a
       `privacy_token` notification, which `Whatsmeow.Session` persists via
       `put/5` so a *future* send has one to attach.

  Issuing never blocks or retries the message itself. Retrying a 463'd send only
  compounds the restriction.

  ## Bucketing

  Tokens live in rolling 7-day buckets, 4 of them (~28 days) — matching the
  server's `tctoken_duration` / `tctoken_num_buckets` AB props. A token older
  than the cutoff is expired and must not be attached. We only re-issue once per
  bucket, tracked by the `sender_timestamp` column, so a chatty conversation
  doesn't spam the server with one IQ per message.
  """

  require Logger

  import Ecto.Query, only: [from: 2]

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Store.Schemas.PrivacyToken, as: Schema
  alias Whatsmeow.Types.JID

  # AB prop `tctoken_duration`: one bucket is 7 days.
  @bucket_seconds 604_800
  # AB prop `tctoken_num_buckets`: 4 rolling buckets ≈ a 28-day validity window.
  @num_buckets 4
  # Floor between re-issues triggered by a 463. A restricted contact rejects a
  # burst, not a single message; without this, each rejection fires its own IQ.
  @reissue_debounce_seconds 60

  @type token_record :: %{
          token: binary(),
          timestamp: integer(),
          sender_timestamp: integer() | nil
        }

  # --- Bucket policy ---------------------------------------------------------

  @doc """
  The oldest timestamp still inside the validity window.

  Anything strictly before this is expired. Bucket-aligned, exactly as Go's
  `currentTCTokenCutoffTimestamp` computes it.
  """
  @spec cutoff(integer()) :: integer()
  def cutoff(now \\ System.system_time(:second)) do
    current_bucket = div(now, @bucket_seconds)
    (current_bucket - (@num_buckets - 1)) * @bucket_seconds
  end

  @doc "True when a stored token's timestamp has fallen out of the rolling window."
  @spec expired?(integer() | nil) :: boolean()
  def expired?(nil), do: true
  def expired?(0), do: true
  def expired?(ts) when is_integer(ts), do: ts < cutoff()

  @doc """
  True when we've crossed a bucket boundary since we last asked the server to
  issue a token for this contact — i.e. it's time to ask again.

  Mirrors Go's `shouldSendNewTCToken`.
  """
  @spec should_issue?(integer() | nil) :: boolean()
  def should_issue?(nil), do: true
  def should_issue?(0), do: true

  def should_issue?(sender_ts) when is_integer(sender_ts) do
    div(System.system_time(:second), @bucket_seconds) > div(sender_ts, @bucket_seconds)
  end

  @doc """
  True when `jid` is a chat we should exchange tctokens with: a real 1:1 human
  contact on the phone-number or LID server. Never groups, the PSA account, or
  Meta's bots.

  Mirrors Go's `shouldSendTCTokenInChatAction`.
  """
  @spec eligible?(JID.t()) :: boolean()
  def eligible?(%JID{} = jid) do
    jid = JID.to_non_ad(jid)

    jid.server in [JID.default_user_server(), JID.hidden_user_server()] and
      jid.user != JID.psa_user() and not JID.bot?(jid)
  end

  # --- Storage ---------------------------------------------------------------

  @doc """
  Load the stored token record for `their_jid`, or `:not_found`.

  Returns the raw record including an expired token — callers that are about to
  put one on the wire want `fetch/2`, which filters expiry for them.
  """
  @spec get(String.t(), JID.t() | String.t()) :: {:ok, token_record()} | :not_found
  def get(our_jid, their_jid) when is_binary(our_jid) do
    their = storage_key(their_jid)

    if repo_up?() do
      case Whatsmeow.Repo.get_by(Schema, our_jid: our_jid, their_jid: their) do
        %Schema{token: token, timestamp: ts, sender_timestamp: sender_ts}
        when is_binary(token) and byte_size(token) > 0 ->
          {:ok, %{token: token, timestamp: ts, sender_timestamp: sender_ts}}

        _ ->
          :not_found
      end
    else
      :not_found
    end
  rescue
    _ -> :not_found
  end

  @doc """
  The send-path read: return an unexpired token ready to attach, or `:not_found`.
  """
  @spec fetch(String.t(), JID.t() | String.t()) :: {:ok, binary()} | :not_found
  def fetch(our_jid, their_jid) do
    case get(our_jid, their_jid) do
      {:ok, %{token: token, timestamp: ts}} ->
        if expired?(ts), do: :not_found, else: {:ok, token}

      :not_found ->
        :not_found
    end
  end

  @doc """
  Persist a token issued for `their_jid`.

  `sender_timestamp` is when *we* last asked the server to issue — pass `nil` to
  leave whatever is already stored untouched.
  """
  @spec put(String.t(), JID.t() | String.t(), binary(), integer(), integer() | nil) ::
          :ok | {:error, term()}
  def put(our_jid, their_jid, token, timestamp, sender_timestamp \\ nil)
      when is_binary(our_jid) and is_binary(token) and is_integer(timestamp) do
    their = storage_key(their_jid)

    if repo_up?() do
      attrs = %{
        our_jid: our_jid,
        their_jid: their,
        token: token,
        timestamp: timestamp,
        sender_timestamp: sender_timestamp
      }

      # Only overwrite sender_timestamp when we were given one — a token
      # arriving from the server carries no knowledge of when we last issued.
      replace =
        if is_nil(sender_timestamp),
          do: [:token, :timestamp],
          else: [:token, :timestamp, :sender_timestamp]

      %Schema{}
      |> Schema.changeset(attrs)
      |> Whatsmeow.Repo.insert(
        on_conflict: {:replace, replace},
        conflict_target: [:our_jid, :their_jid]
      )
      |> case do
        {:ok, _} -> :ok
        {:error, _} = err -> err
      end
    else
      {:error, :no_repo}
    end
  rescue
    e -> {:error, {:repo, Exception.message(e)}}
  end

  @doc """
  Record that we just asked the server to issue a token for `their_jid`, so we
  don't ask again until the next bucket.

  No-ops when we have no row yet — the row is created when the token itself
  arrives, and until then `should_issue?/1` returning true is harmless.
  """
  @spec touch_sender_timestamp(String.t(), JID.t() | String.t(), integer()) :: :ok
  def touch_sender_timestamp(our_jid, their_jid, ts) when is_integer(ts) do
    their = storage_key(their_jid)

    if repo_up?() do
      _ =
        Whatsmeow.Repo.update_all(
          from(p in Schema, where: p.our_jid == ^our_jid and p.their_jid == ^their),
          set: [sender_timestamp: ts]
        )
    end

    :ok
  rescue
    _ -> :ok
  end

  @doc "Drop every token that has fallen out of the rolling window. Returns the count."
  @spec delete_expired(String.t()) :: non_neg_integer()
  def delete_expired(our_jid) when is_binary(our_jid) do
    if repo_up?() do
      cutoff = cutoff()

      {count, _} =
        Whatsmeow.Repo.delete_all(
          from(p in Schema, where: p.our_jid == ^our_jid and p.timestamp < ^cutoff)
        )

      count
    else
      0
    end
  rescue
    _ -> 0
  end

  # --- Protocol --------------------------------------------------------------

  @doc """
  Build the `privacy` IQ that asks the server to issue a trusted-contact token
  for `peer`.

      <iq id="…" to="s.whatsapp.net" type="set" xmlns="privacy">
        <tokens><token jid="…" t="…" type="trusted_contact"/></tokens>
      </iq>

  Ports Go's `issuePrivacyToken` (`whatsmeow-main/tctoken.go:183`).
  """
  @spec build_issue_iq(JID.t(), integer(), String.t() | nil) :: Node.t()
  def build_issue_iq(%JID{} = peer, timestamp, id \\ nil) when is_integer(timestamp) do
    token =
      Node.new(
        "token",
        %{
          "jid" => JID.to_non_ad(peer),
          "t" => Integer.to_string(timestamp),
          "type" => "trusted_contact"
        },
        nil
      )

    Node.new(
      "iq",
      %{
        "id" => id || Whatsmeow.IQ.generate_id(),
        "to" => %JID{user: "", server: JID.default_user_server()},
        "type" => "set",
        "xmlns" => "privacy"
      },
      [Node.new("tokens", %{}, [token])]
    )
  end

  @doc """
  Ask the server to issue a token for `peer`, in the background.

  Fire-and-forget by design: the reply carries no token (that arrives later as a
  `privacy_token` notification), and a failure here must never fail the send that
  triggered it. Skips the round-trip entirely when `peer` isn't tctoken-eligible
  or we already issued inside the current bucket.
  """
  @spec issue_async(pid() | String.t(), String.t(), JID.t()) :: :ok
  def issue_async(server, our_jid, %JID{} = peer) when is_binary(our_jid) do
    if eligible?(peer) and should_issue?(last_issued_at(our_jid, peer)) do
      Task.start(fn -> issue(server, our_jid, peer) end)
    end

    :ok
  end

  @doc """
  Re-issue a token after the server rejected a send with error 463.

  The rejection proves whatever we hold (if anything) is not trusted, so this
  bypasses the once-per-bucket gate that `issue_async/3` respects — but not
  entirely. A restricted contact typically rejects a *burst* of messages, and one
  IQ per rejection is a self-inflicted flood. `@reissue_debounce_seconds` is the
  floor: at most one re-issue per contact per minute.

  The rejected message itself is never retried. Baileys' `handleBadAck` is
  explicit that retrying a 463 compounds the restriction.
  """
  @spec reissue_after_rejection(pid() | String.t(), String.t(), JID.t()) :: :ok | {:error, term()}
  def reissue_after_rejection(server, our_jid, %JID{} = peer) do
    now = System.system_time(:second)

    if eligible?(peer) and now - last_issued_at(our_jid, peer) >= @reissue_debounce_seconds do
      issue(server, our_jid, peer)
    else
      :ok
    end
  end

  # --- Last-issued clock -----------------------------------------------------
  #
  # Both gates — the once-per-bucket one on the send path and the once-a-minute
  # one after a 463 — need "when did we last ask the server about this contact?".
  #
  # The database cannot answer it. `whatsmeow_privacy_tokens` requires a token,
  # and the whole point of a 463 is that we have never received one, so there is
  # no row to stamp. Go has the same problem and solves it the same way: an
  # in-memory map (`tcTokenSenderTS`), with the DB column as durable backing that
  # is only read on a miss.

  @clock_table :whatsmeow_tctoken_issued_at

  @doc false
  @spec last_issued_at(String.t(), JID.t() | String.t()) :: integer()
  def last_issued_at(our_jid, peer) do
    key = {our_jid, storage_key(peer)}
    ensure_clock()

    case :ets.lookup(@clock_table, key) do
      [{^key, ts}] ->
        ts

      [] ->
        # First look this boot: fall back to whatever the durable column holds,
        # so a restart doesn't hand every contact a free re-issue.
        ts =
          case get(our_jid, peer) do
            {:ok, %{sender_timestamp: stored}} when is_integer(stored) -> stored
            _ -> 0
          end

        :ets.insert(@clock_table, {key, ts})
        ts
    end
  rescue
    _ -> 0
  end

  @doc false
  @spec mark_issued(String.t(), JID.t() | String.t(), integer()) :: :ok
  def mark_issued(our_jid, peer, ts) when is_integer(ts) do
    ensure_clock()
    :ets.insert(@clock_table, {{our_jid, storage_key(peer)}, ts})
    :ok
  rescue
    _ -> :ok
  end

  defp ensure_clock do
    case :ets.whereis(@clock_table) do
      :undefined ->
        try do
          :ets.new(@clock_table, [:named_table, :public, :set, read_concurrency: true])
        rescue
          # Another process won the create race; the table exists either way.
          ArgumentError -> :ok
        end

      _ ->
        :ok
    end

    :ok
  end

  @doc """
  The synchronous half of `issue_async/3`. Exposed for tests and for callers that
  want to know whether the server accepted the request.
  """
  @spec issue(pid() | String.t(), String.t(), JID.t()) :: :ok | {:error, term()}
  def issue(server, our_jid, %JID{} = peer) do
    now = System.system_time(:second)

    case Whatsmeow.Session.send_iq(server, build_issue_iq(peer, now)) do
      {:ok, _reply} ->
        # Both halves: the in-memory clock is what the gates read, the column is
        # what survives a restart.
        mark_issued(our_jid, peer, now)
        touch_sender_timestamp(our_jid, peer, now)
        :ok

      {:error, reason} = err ->
        Logger.debug(fn ->
          "[whatsmeow] privacy token issue failed for #{JID.to_string(peer)}: #{inspect(reason)}"
        end)

        err
    end
  end

  @doc """
  Persist the token carried by a `privacy_token` notification.

  `Whatsmeow.Notification` has already decoded the node into a
  `%Whatsmeow.Types.Events.PrivacyToken{}`; this is the write half that was
  missing, and without it the store stays empty forever and every 1:1 send goes
  out untokenised.
  """
  @spec store_notification(String.t(), map()) :: :ok | {:error, term()}
  def store_notification(our_jid, %{from: %JID{} = from, token: token, timestamp: ts})
      when is_binary(token) and byte_size(token) > 0 do
    put(our_jid, from, token, normalize_ts(ts))
  end

  def store_notification(_our_jid, _), do: {:error, :no_token}

  # --- Helpers ---------------------------------------------------------------

  defp storage_key(%JID{} = jid), do: jid |> JID.to_non_ad() |> JID.to_string()
  defp storage_key(s) when is_binary(s), do: s

  defp normalize_ts(%DateTime{} = dt), do: DateTime.to_unix(dt)
  defp normalize_ts(ts) when is_integer(ts), do: ts
  defp normalize_ts(_), do: System.system_time(:second)

  defp repo_up? do
    Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))
  end
end
