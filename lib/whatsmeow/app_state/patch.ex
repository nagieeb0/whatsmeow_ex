defmodule Whatsmeow.AppState.Patch do
  @moduledoc """
  An outgoing app-state patch, and the builders for the ones this library
  sends.

  Ports `PatchInfo`, `MutationInfo`, `BuildArchive`, `BuildPin`,
  `BuildMarkChatAsRead` and `newMessageRange` from
  `whatsmeow-main/appstate/encode.go`. Encoding (encryption, MACs, the
  `SyncdPatch` protobuf) is `Whatsmeow.AppState.Encode.encode_syncd_patch/6`.

  * `:type` — the collection (`"regular_low"` for archive, pin and
    markChatAsRead)
  * `:mutations` — `[%{index: [String.t()], version: integer(), value:
    %WAWebProtobufSyncAction.SyncActionValue{}}]`
  * `:timestamp` — milliseconds stamped on every value; `nil` means "now",
    filled in at encode time as Go does
  """

  alias Whatsmeow.Types.JID
  alias WAWebProtobufSyncAction, as: SA

  @index_archive "archive"
  @index_pin "pin_v1"
  @index_mark_chat_as_read "markChatAsRead"

  defstruct type: nil, mutations: [], timestamp: nil

  @type mutation :: %{index: [String.t()], version: integer(), value: SA.SyncActionValue.t()}
  @type t :: %__MODULE__{
          type: String.t(),
          mutations: [mutation()],
          timestamp: integer() | nil
        }

  @doc """
  Archive or unarchive a chat. Archiving also unpins it, as Go's
  `BuildArchive` does (a second mutation on `["pin_v1", jid]`).

  `last_message_ts` is unix seconds (`nil` or `0` → now) and
  `last_message_key` an optional `%WACommon.MessageKey{}` — both optional in
  Go too.
  """
  @spec build_archive(JID.t() | String.t(), boolean(), integer() | nil, struct() | nil) :: t()
  def build_archive(target, archive?, last_message_ts \\ nil, last_message_key \\ nil)
      when is_boolean(archive?) do
    jid = jid_string(target)

    archive = %{
      index: [@index_archive, jid],
      version: 3,
      value: %SA.SyncActionValue{
        archiveChatAction: %SA.ArchiveChatAction{
          archived: archive?,
          messageRange: message_range(last_message_ts, last_message_key)
        }
      }
    }

    mutations = if archive?, do: [archive, pin_mutation(jid, false)], else: [archive]
    %__MODULE__{type: "regular_low", mutations: mutations}
  end

  @doc "Pin or unpin a chat (Go's `BuildPin`)."
  @spec build_pin(JID.t() | String.t(), boolean()) :: t()
  def build_pin(target, pin?) when is_boolean(pin?) do
    %__MODULE__{type: "regular_low", mutations: [pin_mutation(jid_string(target), pin?)]}
  end

  @doc "Mark a chat read or unread (Go's `BuildMarkChatAsRead`)."
  @spec build_mark_chat_as_read(JID.t() | String.t(), boolean(), integer() | nil, struct() | nil) ::
          t()
  def build_mark_chat_as_read(target, read?, last_message_ts \\ nil, last_message_key \\ nil)
      when is_boolean(read?) do
    %__MODULE__{
      type: "regular_low",
      mutations: [
        %{
          index: [@index_mark_chat_as_read, jid_string(target)],
          version: 3,
          value: %SA.SyncActionValue{
            markChatAsReadAction: %SA.MarkChatAsReadAction{
              read: read?,
              messageRange: message_range(last_message_ts, last_message_key)
            }
          }
        }
      ]
    }
  end

  defp pin_mutation(jid, pin?) do
    %{
      index: [@index_pin, jid],
      version: 5,
      value: %SA.SyncActionValue{pinAction: %SA.PinAction{pinned: pin?}}
    }
  end

  # Go's `newMessageRange`: a zero time means now, in unix *seconds*.
  defp message_range(ts, key) do
    ts = if ts in [nil, 0], do: System.os_time(:second), else: ts
    messages = if key, do: [%SA.SyncActionMessage{key: key, timestamp: ts}], else: []
    %SA.SyncActionMessageRange{lastMessageTimestamp: ts, messages: messages}
  end

  defp jid_string(%JID{} = jid), do: JID.to_string(jid)
  defp jid_string(jid) when is_binary(jid), do: jid

  @doc """
  JSON-encode an index exactly as Go's `json.Marshal([]string)` does.

  The index MAC is an HMAC over these bytes, so they must match what every
  other device computes. Go escapes `<`, `>`, `&`, U+2028 and U+2029 as
  `\\u00XX`/`\\u20XX`, uses the short escapes `\\b \\f \\n \\r \\t`, writes
  other control characters as `\\u00XX`, and replaces invalid UTF-8 with
  U+FFFD. JIDs never hit those cases; this is so an odd index cannot
  silently produce a MAC nobody else agrees with.
  """
  @spec index_json([String.t()]) :: binary()
  def index_json(parts) when is_list(parts) do
    IO.iodata_to_binary(["[", Enum.map_intersperse(parts, ",", &go_json_string/1), "]"])
  end

  defp go_json_string(s) when is_binary(s), do: [?", escape(s, []), ?"]

  defp escape(<<>>, acc), do: Enum.reverse(acc)
  defp escape(<<?", rest::binary>>, acc), do: escape(rest, ["\\\"" | acc])
  defp escape(<<?\\, rest::binary>>, acc), do: escape(rest, ["\\\\" | acc])
  defp escape(<<?\b, rest::binary>>, acc), do: escape(rest, ["\\b" | acc])
  defp escape(<<?\f, rest::binary>>, acc), do: escape(rest, ["\\f" | acc])
  defp escape(<<?\n, rest::binary>>, acc), do: escape(rest, ["\\n" | acc])
  defp escape(<<?\r, rest::binary>>, acc), do: escape(rest, ["\\r" | acc])
  defp escape(<<?\t, rest::binary>>, acc), do: escape(rest, ["\\t" | acc])

  defp escape(<<c, rest::binary>>, acc) when c < 0x20 or c in [?<, ?>, ?&],
    do: escape(rest, [u_escape(c) | acc])

  defp escape(<<c::utf8, rest::binary>>, acc) when c in [0x2028, 0x2029],
    do: escape(rest, [u_escape(c) | acc])

  defp escape(<<c::utf8, rest::binary>>, acc), do: escape(rest, [<<c::utf8>> | acc])
  defp escape(<<_invalid, rest::binary>>, acc), do: escape(rest, ["\\ufffd" | acc])

  defp u_escape(c),
    do: "\\u" <> String.pad_leading(Integer.to_string(c, 16) |> String.downcase(), 4, "0")
end
