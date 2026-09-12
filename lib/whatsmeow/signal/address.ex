defmodule Whatsmeow.Signal.Address do
  @moduledoc """
  The address a Signal session is filed under.

  WhatsApp is moving every account from phone-number addressing
  (`<digits>@s.whatsapp.net`, "PN") to hidden-user addressing
  (`<digits>@lid`, "LID"). Mid-migration a single physical device answers to
  **both** names, and the server volunteers whichever one it feels like on any
  given stanza.

  Filing crypto state under "whatever the wire said" therefore splits one
  device across two session records with two independent ratchets. The observed
  failure is precise and one-sided: replies decrypt on the recipient's
  companion devices (PN in both directions, never split) and render as
  *"في انتظار هذه الرسالة"* on their phone, which is the device that moved to
  LID. The first message of a conversation lands — it establishes a session —
  and every message after it is another `pkmsg` citing a one-time prekey the
  phone already consumed.

  So the session key is **not** the wire address. It is the *encryption
  identity*, canonicalised to LID whenever a mapping is known. This mirrors
  upstream Go, which keeps `encryptionIdentity` and the `<to>` address as two
  separate values (`whatsmeow-main/send.go`, `message.go`, `retry.go`).

  ## Direction

  LID, not PN — the direction WhatsApp is migrating toward. Canonicalising the
  other way works today and breaks again the moment an account completes its
  migration and stops answering to its number.

  ## Cost

  One indexed single-row lookup (`whatsmeow_lid_map`, unique on both `lid` and
  `pn`) per peer device per message, and it is deliberately taken *outside* the
  `Whatsmeow.Signal.Lock` critical section — see the callers. Unmapped peers,
  groups, broadcast and newsletter JIDs pass through untouched, so a
  deployment with no LID mappings pays one miss per send and behaves exactly as
  before.
  """

  alias Whatsmeow.LIDMap
  alias Whatsmeow.Types.JID

  @doc """
  The LID form of `jid` when one is known, otherwise `jid` unchanged.

  Device and agent survive the translation — `966511792082:15@s.whatsapp.net`
  becomes `132680784040127:15@lid`, not the bare LID — because a session is per
  *device*, not per person.
  """
  @spec encryption_identity(JID.t() | String.t() | nil) :: JID.t() | nil
  def encryption_identity(nil), do: nil

  def encryption_identity(jid) do
    case to_jid(jid) do
      {:ok, %JID{server: server} = j} ->
        if server == JID.default_user_server() do
          LIDMap.lid_for(j) || j
        else
          # Already LID, or a server with no LID concept at all (groups,
          # broadcast, newsletter, bots). Nothing to canonicalise.
          j
        end

      :error ->
        nil
    end
  end

  @doc """
  `encryption_identity/1` rendered as the string used to key session storage.

  Returns `""` for anything unparseable, matching what the decrypt path already
  did with a malformed `from` — an empty key that finds no session, rather than
  a crash on a stanza we cannot address anyway.
  """
  @spec session_key(JID.t() | String.t() | nil) :: String.t()
  def session_key(jid) do
    case encryption_identity(jid) do
      %JID{} = canonical -> JID.to_string(canonical)
      nil -> ""
    end
  end

  defp to_jid(%JID{} = j), do: {:ok, j}

  defp to_jid(s) when is_binary(s) and s != "" do
    case JID.parse(s) do
      {:ok, %JID{} = j} -> {:ok, j}
      _ -> :error
    end
  end

  defp to_jid(_), do: :error
end
