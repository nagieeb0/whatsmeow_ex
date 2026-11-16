defmodule Whatsmeow.AppState do
  @moduledoc """
  Chat archive and mark-as-read, sent as WhatsApp app-state patches.

  This is the implementation behind `Whatsmeow.archive_chat/3`,
  `Whatsmeow.unarchive_chat/3`, `Whatsmeow.mark_chat_read/3` and
  `Whatsmeow.mark_chat_unread/3`; see `Whatsmeow.archive_chat/3` for the contract.

  > #### Trial this on a spare number first {: .warning}
  >
  > An app-state patch is **end-to-end encrypted, and the keys are shared only
  > between your own devices**, so the server has no way to check its MACs: all it
  > can check is the version a patch extends. A patch with a wrong MAC is therefore
  > accepted, forwarded to your phone, and rejected *there*. What the phone then does
  > is not something this project has observed — at minimum it breaks app-state sync
  > for that collection, and Go whatsmeow documents a "fatal app state exception"
  > recovery path that logs out all linked devices.
  >
  > The encoding here is verified byte-for-byte against Go whatsmeow's, every
  > patch is decoded back and MAC-verified before it is sent, and the test suite
  > runs the real Go `appstate` package over our output. None of that has been run
  > against a live WhatsApp account. **Do not make a personal number's first
  > `archive_chat/3` call a production one.**

  ## What gets sent

    * archive — `["archive", jid]` and, as Go does, `["pin_v1", jid]` (unpin);
    * unarchive — `["archive", jid]` only;
    * mark read / unread — `["markChatAsRead", jid]`.

  All in the `regular_low` collection. See `Whatsmeow.AppState.Patch`.

  ## Preconditions

  The phone must have shared its app-state keys with this device
  (`Whatsmeow.AppState.KeyShare`). A device paired before this feature existed
  has none; its first call returns `{:error, {:key_not_found, key_id}}` after
  asking the phone for the key, and succeeds on retry once the phone has answered.

  ## What it does *not* do

  Mutations made on the phone (a chat archived there, say) are verified and
  applied to the stored state — they have to be, or the next send would conflict —
  but no event is emitted for them, and no chat-settings table is updated.
  """

  alias Whatsmeow.AppState.{Patch, Sync}
  alias Whatsmeow.Types.JID

  @typedoc """
  What the caller knows about the chat's most recent message. All optional:

    * `nil` — no range; the timestamp is "now" (Go: zero values);
    * an integer (Unix seconds) or `DateTime` — the last message's timestamp;
    * `{timestamp, key}` / `{timestamp, [key]}`;
    * a keyword list or map with `:last_message_timestamp` (or `:timestamp`) and
      `:last_message_key` / `:message_key` / `:messages` (one key, or a list).

  A *key* is `%{id: "3EB0…", remote_jid: "…@s.whatsapp.net", from_me: false,
  participant: nil}` (or a `WACommon.MessageKey`).

  Timestamps are seconds; an integer that can only be milliseconds is converted.
  """
  @type last_message :: nil | integer() | DateTime.t() | tuple() | keyword() | map()

  @type result :: {:ok, non_neg_integer()} | {:error, term()}

  @chat_servers ["s.whatsapp.net", "lid", "g.us"]

  @doc "Archive a chat (and unpin it, as Go does). `{:ok, new_collection_version}` or `{:error, reason}`."
  @spec archive_chat(pid() | String.t(), JID.t() | String.t(), last_message(), keyword()) ::
          result()
  def archive_chat(session, jid, last_message \\ nil, run_opts \\ []),
    do: run(session, jid, last_message, run_opts, &Patch.build_archive(&1, true, &2, &3))

  @doc "Unarchive a chat."
  @spec unarchive_chat(pid() | String.t(), JID.t() | String.t(), last_message(), keyword()) ::
          result()
  def unarchive_chat(session, jid, last_message \\ nil, run_opts \\ []),
    do: run(session, jid, last_message, run_opts, &Patch.build_archive(&1, false, &2, &3))

  @doc "Mark a chat read."
  @spec mark_chat_read(pid() | String.t(), JID.t() | String.t(), last_message(), keyword()) ::
          result()
  def mark_chat_read(session, jid, last_message \\ nil, run_opts \\ []),
    do: run(session, jid, last_message, run_opts, &Patch.build_mark_chat_as_read(&1, true, &2, &3))

  @doc "Mark a chat unread."
  @spec mark_chat_unread(pid() | String.t(), JID.t() | String.t(), last_message(), keyword()) ::
          result()
  def mark_chat_unread(session, jid, last_message \\ nil, run_opts \\ []),
    do: run(session, jid, last_message, run_opts, &Patch.build_mark_chat_as_read(&1, false, &2, &3))

  @doc """
  Fetch and verify a collection without sending anything (default `"regular_low"`).
  `full_sync: true` discards the stored state and re-reads everything — the way out
  of a collection whose local state has diverged. Never raises.
  """
  @spec sync(pid() | String.t(), String.t(), keyword()) ::
          {:ok, non_neg_integer()} | {:error, term()}
  def sync(session, name \\ "regular_low", opts \\ []) do
    guarded(fn ->
      case Sync.fetch(session, name, opts) do
        {:ok, state} -> {:ok, state.version}
        {:error, _} = err -> err
      end
    end)
  end

  # --- internals ----------------------------------------------------------------

  defp run(session, jid, last_message, run_opts, build) do
    guarded(fn ->
      with {:ok, jid} <- chat_jid(jid),
           {:ok, ts, keys} <- last_message(last_message),
           :ok <- check_online(session, run_opts),
           {:ok, state} <- Sync.send_patch(session, build.(jid, ts, keys), run_opts) do
        {:ok, state.version}
      end
    end)
  end

  # Whatever happens below, the caller gets a tuple — this runs inside a host
  # application's worker, and an app-state failure must not take it down.
  defp guarded(fun) do
    fun.()
  rescue
    e -> {:error, {:exception, Exception.message(e)}}
  catch
    :exit, reason -> {:error, {:exit, reason}}
  end

  # A sandbox/offline session records sends instead of transmitting them; reporting
  # an archive as done there would be a lie.
  defp check_online(session, run_opts) do
    cond do
      Keyword.has_key?(run_opts, :send_iq) -> :ok
      is_nil(session) -> {:error, :no_session}
      Whatsmeow.Session.offline?(session) -> {:error, :offline_session}
      true -> :ok
    end
  end

  # The index of an archive/read mutation is `[name, jid]` and the phone looks the
  # chat up by that exact string. A device-qualified JID (`…:5@s.whatsapp.net`) or
  # a server that is not a chat would produce a mutation for a chat that does not
  # exist; refuse rather than send it.
  @doc false
  @spec chat_jid(JID.t() | String.t() | term()) :: {:ok, String.t()} | {:error, term()}
  def chat_jid(%JID{} = jid), do: validate_chat_jid(jid)

  def chat_jid(jid) when is_binary(jid) and jid != "" do
    case JID.parse(jid) do
      {:ok, %JID{} = parsed} -> validate_chat_jid(parsed)
      _ -> {:error, :invalid_jid}
    end
  end

  def chat_jid(_), do: {:error, :invalid_jid}

  # Strict on purpose. The phone looks a chat up by this exact string, and a patch
  # is permanent — this library only ever emits SETs, so it cannot take back a
  # mutation for a chat that does not exist. Users and LIDs are digits; a group is
  # `digits` or `digits-digits`. No agent, no device.
  defp validate_chat_jid(%JID{user: user, server: server, device: device, agent: agent} = jid) do
    cond do
      user in [nil, ""] -> {:error, :invalid_jid}
      server not in @chat_servers -> {:error, {:unsupported_chat_jid, server}}
      device not in [nil, 0] -> {:error, {:device_jid_not_allowed, JID.to_string(jid)}}
      agent not in [nil, 0] -> {:error, :invalid_jid}
      not valid_user?(server, user) -> {:error, :invalid_jid}
      true -> {:ok, JID.to_string(jid)}
    end
  end

  defp valid_user?("g.us", user) when is_binary(user), do: user =~ ~r/\A\d{1,40}(-\d{1,40})?\z/
  defp valid_user?(_server, user) when is_binary(user), do: user =~ ~r/\A\d{1,40}\z/
  defp valid_user?(_server, _user), do: false

  @doc false
  @spec last_message(last_message()) :: {:ok, integer() | nil, term()} | {:error, term()}
  def last_message(nil), do: {:ok, nil, nil}
  def last_message({ts, keys}), do: with_ts(ts, keys)
  def last_message(ts) when is_integer(ts) or is_struct(ts, DateTime), do: with_ts(ts, nil)

  def last_message(opts) when is_list(opts) do
    if Keyword.keyword?(opts), do: last_message(Map.new(opts)), else: with_ts(nil, opts)
  end

  def last_message(%{} = m) do
    ts = m[:last_message_timestamp] || m[:timestamp] || m[:ts]

    keys =
      m[:last_message_key] || m[:message_key] || m[:key] || m[:messages] || m[:last_message_keys]

    with_ts(ts, keys)
  end

  def last_message(_), do: {:error, :invalid_last_message}

  defp with_ts(ts, keys) when ts in [nil, 0], do: {:ok, nil, keys}

  defp with_ts(ts, keys) do
    case Patch.normalize_seconds(ts) do
      nil -> {:error, :invalid_timestamp}
      secs -> {:ok, secs, keys}
    end
  end
end
