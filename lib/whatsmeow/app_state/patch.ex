defmodule Whatsmeow.AppState.Patch do
  @moduledoc """
  Builders for the app-state patches this library can send.

  Ports the `Build*` functions of `whatsmeow-main/appstate/encode.go`:
  `BuildArchive`, `BuildMarkChatAsRead` and `BuildPin`, with the same indexes,
  per-mutation versions and message-range semantics.

  A `%Patch{}` is one collection name plus a list of `%Mutation{}`s. Every
  mutation here is a SET — Go's encoder only ever emits SETs.

  ## What archiving does on the wire

  `build_archive(jid, true, ...)` is **two** mutations, as in Go:

    1. `["archive", jid]` v3 — `ArchiveChatAction{archived: true, messageRange}`
    2. `["pin_v1", jid]` v5 — `PinAction{pinned: false}`

  Go's doc comment on `BuildArchive` is "Archiving a chat will also unpin it
  automatically", and its implementation appends the unpin mutation when
  archiving; this does the same. `build_archive(jid, false, ...)` is the single
  `archive` mutation.
  """

  alias WACommon.MessageKey

  alias WAWebProtobufSyncAction.{
    ArchiveChatAction,
    MarkChatAsReadAction,
    PinAction,
    SyncActionMessage,
    SyncActionMessageRange,
    SyncActionValue
  }

  alias Whatsmeow.Types.JID

  @regular_low "regular_low"

  defmodule Mutation do
    @moduledoc "One mutation: the thing being mutated, its static version, and its value."
    @enforce_keys [:index, :version, :value]
    defstruct [:index, :version, :value]

    @type t :: %__MODULE__{
            index: [String.t()],
            version: integer(),
            value: WAWebProtobufSyncAction.SyncActionValue.t()
          }
  end

  @enforce_keys [:type, :mutations]
  defstruct [:type, :mutations, :timestamp_ms]

  @typedoc """
  `:timestamp_ms` is when the patch was created; `nil` means "now at encode
  time" (Go: filled in by `EncodePatch` when zero).
  """
  @type t :: %__MODULE__{
          type: String.t(),
          mutations: [Mutation.t()],
          timestamp_ms: integer() | nil
        }

  @typedoc "What a caller may hand us as the chat's last message."
  @type last_message_key :: nil | MessageKey.t() | map() | keyword() | [map() | MessageKey.t()]

  @doc "Go: `BuildArchive`. Archiving also unpins, exactly as Go does."
  @spec build_archive(String.t(), boolean(), integer() | DateTime.t() | nil, last_message_key) ::
          t()
  def build_archive(jid, archive?, last_message_ts \\ nil, last_message_key \\ nil)
      when is_binary(jid) and is_boolean(archive?) do
    archive = %Mutation{
      index: ["archive", jid],
      version: 3,
      value: %SyncActionValue{
        archiveChatAction: %ArchiveChatAction{
          archived: archive?,
          messageRange: message_range(last_message_ts, last_message_key)
        }
      }
    }

    mutations = if archive?, do: [archive, pin_mutation(jid, false)], else: [archive]
    %__MODULE__{type: @regular_low, mutations: mutations}
  end

  @doc "Go: `BuildMarkChatAsRead`."
  @spec build_mark_chat_as_read(
          String.t(),
          boolean(),
          integer() | DateTime.t() | nil,
          last_message_key
        ) :: t()
  def build_mark_chat_as_read(jid, read?, last_message_ts \\ nil, last_message_key \\ nil)
      when is_binary(jid) and is_boolean(read?) do
    %__MODULE__{
      type: @regular_low,
      mutations: [
        %Mutation{
          index: ["markChatAsRead", jid],
          version: 3,
          value: %SyncActionValue{
            markChatAsReadAction: %MarkChatAsReadAction{
              read: read?,
              messageRange: message_range(last_message_ts, last_message_key)
            }
          }
        }
      ]
    }
  end

  @doc "Go: `BuildPin`."
  @spec build_pin(String.t(), boolean()) :: t()
  def build_pin(jid, pin?) when is_binary(jid) and is_boolean(pin?) do
    %__MODULE__{type: @regular_low, mutations: [pin_mutation(jid, pin?)]}
  end

  defp pin_mutation(jid, pinned?) do
    %Mutation{
      index: ["pin_v1", jid],
      version: 5,
      value: %SyncActionValue{pinAction: %PinAction{pinned: pinned?}}
    }
  end

  # Go `newMessageRange`: a zero timestamp means now; both timestamps are Unix
  # *seconds* (the mutation's own `timestamp` is milliseconds — a different
  # field, set at encode time); message entries exist only when keys were given.
  # Go takes one key; a list is accepted too, each entry stamped with the range's
  # timestamp unless it carries its own.
  defp message_range(ts, keys) do
    secs = unix_seconds(ts)

    %SyncActionMessageRange{
      lastMessageTimestamp: secs,
      messages:
        keys
        |> key_items()
        |> Enum.flat_map(fn item ->
          case message_key(item) do
            nil -> []
            %MessageKey{} = k -> [%SyncActionMessage{key: k, timestamp: item_ts(item, secs)}]
          end
        end)
    }
  end

  # A keyword list is ONE key; any other list is a list of keys.
  defp key_items(keys) when is_list(keys) do
    if Keyword.keyword?(keys), do: [keys], else: keys
  end

  defp key_items(key), do: [key]

  # A `%MessageKey{}` has no timestamp and is not Access-able; only plain maps do.
  defp item_ts(%MessageKey{}, default), do: default
  defp item_ts(%{} = m, default), do: normalize_seconds(Map.get(m, :timestamp)) || default
  defp item_ts(_, default), do: default

  # A value this large is not seconds (it would be the year 5138): the caller has
  # passed milliseconds. Converting is unambiguous; guessing the other way would
  # put a timestamp thousands of years out into the user's chat list.
  @ms_threshold 100_000_000_000

  @doc false
  @spec normalize_seconds(term()) :: pos_integer() | nil
  def normalize_seconds(secs) when is_integer(secs) and secs >= @ms_threshold, do: div(secs, 1000)
  def normalize_seconds(secs) when is_integer(secs) and secs > 0, do: secs
  def normalize_seconds(%DateTime{} = dt), do: DateTime.to_unix(dt, :second)
  def normalize_seconds(_), do: nil

  defp unix_seconds(ts), do: normalize_seconds(ts) || System.os_time(:second)

  @doc false
  @spec message_key(last_message_key) :: MessageKey.t() | nil
  def message_key(nil), do: nil
  def message_key(%MessageKey{} = k), do: k
  def message_key(kw) when is_list(kw), do: kw |> Map.new() |> message_key()

  def message_key(%{} = m) do
    id = m[:id] || m[:ID]

    if is_binary(id) and id != "" do
      %MessageKey{
        ID: id,
        remoteJID: stringify(m[:remote_jid] || m[:remoteJID]),
        fromMe: (m[:from_me] || m[:fromMe]) == true,
        participant: stringify(m[:participant])
      }
    end
  end

  defp stringify(nil), do: nil
  defp stringify(s) when is_binary(s), do: s
  defp stringify(%JID{} = j), do: JID.to_string(j)
  defp stringify(_), do: nil
end
