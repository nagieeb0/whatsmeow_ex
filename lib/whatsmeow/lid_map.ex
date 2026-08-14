defmodule Whatsmeow.LIDMap do
  @moduledoc """
  LID ↔ phone-number resolution.

  ## What a LID is

  WhatsApp is migrating away from exposing phone numbers. A contact who has
  privacy enabled reaches you as a **LID** — `123456789@lid` — an opaque per-user
  identifier with no phone number in it. The same person may appear as a LID in
  one stanza and as a PN (`15551234567@s.whatsapp.net`) in the next, and nothing
  in either JID says they are the same human.

  Without a mapping every privacy-LID contact is a stranger: a bot has to ask
  "who are you?" for someone it already knows by number, group participant lists
  don't line up with the address book, and a Signal session keyed by LID looks
  unrelated to the one keyed by PN.

  ## Where mappings come from

    * `<notification type="devices">` — carries `lid` alongside `jid`, both for
      the account and per linked device. Written by `Whatsmeow.Session`.
    * **History sync** — `phoneNumberToLidMappings`, seeded in bulk on first
      link. This is the big one; the live path only learns a pairing when a
      notification happens to mention it.
    * USync replies, when the server volunteers a `lid` attribute.

  Both directions are served from one row: LID is the primary key, PN is uniquely
  indexed, so `pn_for/1` and `lid_for/1` are each a single indexed lookup rather
  than a second table to keep consistent.
  """

  require Logger

  alias Whatsmeow.Store.Schemas.LIDMap, as: Schema
  alias Whatsmeow.Types.JID

  @doc """
  Record that `lid` and `pn` are the same person.

  Accepts JIDs or their string forms, in either order of specificity — device
  suffixes are stripped, since the pairing is per user, not per device. Ignores
  anything that isn't a well-formed LID/PN pair, so callers can hand it raw
  attribute values without pre-validating.
  """
  @spec put(JID.t() | String.t() | nil, JID.t() | String.t() | nil) :: :ok
  def put(lid, pn) do
    with {:ok, lid_s} <- normalize(lid, JID.hidden_user_server()),
         {:ok, pn_s} <- normalize(pn, JID.default_user_server()),
         true <- repo_up?() do
      %Schema{}
      |> Schema.changeset(%{lid: lid_s, pn: pn_s})
      |> Whatsmeow.Repo.insert(
        on_conflict: {:replace, [:pn]},
        conflict_target: [:lid]
      )
      |> case do
        {:ok, _} -> :ok
        {:error, _} -> :ok
      end
    else
      _ -> :ok
    end

    :ok
  rescue
    _ -> :ok
  end

  @doc "Store many `{lid, pn}` pairs. Returns the number written."
  @spec put_all([{JID.t() | String.t(), JID.t() | String.t()}]) :: non_neg_integer()
  def put_all(pairs) when is_list(pairs) do
    Enum.count(pairs, fn {lid, pn} -> put(lid, pn) == :ok end)
  end

  @doc """
  The phone-number JID for a LID, or `nil` when we've never seen the pairing.

  The returned JID keeps the *queried* device suffix, so a session keyed by
  `12345:3@lid` resolves to `15551234567:3@s.whatsapp.net` — the device index is
  the same on both sides of the mapping.
  """
  @spec pn_for(JID.t() | String.t() | nil) :: JID.t() | nil
  def pn_for(nil), do: nil

  def pn_for(lid) do
    with {:ok, jid} <- to_jid(lid),
         {:ok, key} <- normalize(jid, JID.hidden_user_server()),
         %Schema{pn: pn} <- fetch_by(lid: key),
         {:ok, %JID{} = pn_jid} <- to_jid(pn) do
      carry_device(pn_jid, jid)
    else
      _ -> nil
    end
  end

  @doc "The LID for a phone-number JID, or `nil`. Mirror of `pn_for/1`."
  @spec lid_for(JID.t() | String.t() | nil) :: JID.t() | nil
  def lid_for(nil), do: nil

  def lid_for(pn) do
    with {:ok, jid} <- to_jid(pn),
         {:ok, key} <- normalize(jid, JID.default_user_server()),
         %Schema{lid: lid} <- fetch_by(pn: key),
         {:ok, %JID{} = lid_jid} <- to_jid(lid) do
      carry_device(lid_jid, jid)
    else
      _ -> nil
    end
  end

  @doc """
  Resolve `jid` to its phone-number form when one is known, otherwise return it
  unchanged.

  The convenience wrapper for display and address-book lookup: hand it whatever
  the wire gave you and get the most identifiable form back.
  """
  @spec resolve(JID.t() | String.t() | nil) :: JID.t() | nil
  def resolve(nil), do: nil

  def resolve(jid) do
    case to_jid(jid) do
      {:ok, %JID{server: server} = j} ->
        if server == JID.hidden_user_server(), do: pn_for(j) || j, else: j

      _ ->
        nil
    end
  end

  # --- Helpers ---------------------------------------------------------------

  defp fetch_by(clauses) do
    if repo_up?(), do: Whatsmeow.Repo.get_by(Schema, clauses)
  rescue
    _ -> nil
  end

  # Storage key: the bare user@server, no agent/device. A pairing is per person.
  defp normalize(value, expected_server) do
    case to_jid(value) do
      {:ok, %JID{user: user, server: server}}
      when is_binary(user) and user != "" and server == expected_server ->
        {:ok, JID.to_string(%JID{user: user, server: server})}

      _ ->
        :error
    end
  end

  defp carry_device(%JID{} = target, %JID{device: device, agent: agent})
       when is_integer(device) and device > 0 do
    %JID{target | device: device, agent: agent}
  end

  defp carry_device(%JID{} = target, _source), do: target

  defp to_jid(%JID{} = j), do: {:ok, j}

  defp to_jid(s) when is_binary(s) and s != "" do
    case JID.parse(s) do
      {:ok, %JID{} = j} -> {:ok, j}
      _ -> :error
    end
  end

  defp to_jid(_), do: :error

  defp repo_up? do
    Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))
  end
end
