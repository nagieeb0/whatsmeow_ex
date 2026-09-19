defmodule Whatsmeow.Binary.Node do
  @moduledoc """
  An XML-like tree node in WhatsApp's wire format.

  A `Node` has a `tag` (string), an `attrs` map (string-keyed), and `content`
  which is one of: `nil`, a binary, or a list of child `Node`s.

  This matches `whatsmeow-main/binary/node.go`. Attribute values may be
  binaries, JIDs, integers, or booleans depending on the tag — the codec
  passes them through unchanged and helpers (`Attrs`) coerce on access.

  Iron Law: `tag` and attribute keys are **strings**, never atoms — the
  decoder never calls `String.to_atom/1` on values from the network.
  """

  @enforce_keys [:tag]
  defstruct tag: "", attrs: %{}, content: nil

  @type attr_value :: binary() | integer() | boolean() | Whatsmeow.Types.JID.t()
  @type content :: nil | binary() | [t()]

  @type t :: %__MODULE__{
          tag: String.t(),
          attrs: %{optional(String.t()) => attr_value()},
          content: content()
        }

  @doc "Build a node with the given tag, attrs, and content."
  @spec new(String.t(), map(), content()) :: t()
  def new(tag, attrs \\ %{}, content \\ nil)
      when is_binary(tag) and is_map(attrs) do
    %__MODULE__{tag: tag, attrs: attrs, content: content}
  end

  @doc """
  Return the first direct child node whose tag matches `tag`. Returns `nil`
  when content is not a list or no match is found.
  """
  @spec get_child(t(), String.t()) :: t() | nil
  def get_child(%__MODULE__{content: children}, tag) when is_list(children) and is_binary(tag) do
    Enum.find(children, fn
      %__MODULE__{tag: ^tag} -> true
      _ -> false
    end)
  end

  def get_child(%__MODULE__{}, _), do: nil

  @doc "Return all direct children whose tag matches `tag`."
  @spec get_children(t(), String.t()) :: [t()]
  def get_children(%__MODULE__{content: children}, tag) when is_list(children) and is_binary(tag) do
    Enum.filter(children, fn
      %__MODULE__{tag: ^tag} -> true
      _ -> false
    end)
  end

  def get_children(%__MODULE__{}, _), do: []

  @doc "Return the list of children, or `[]` when `content` is not a list."
  @spec children(t()) :: [t()]
  def children(%__MODULE__{content: c}) when is_list(c), do: c
  def children(%__MODULE__{}), do: []

  @doc "Iron Law: never convert wire strings to atoms."
  @spec attr(t(), String.t(), term()) :: term()
  def attr(%__MODULE__{attrs: attrs}, key, default \\ nil) when is_binary(key) do
    Map.get(attrs, key, default)
  end

  # Attributes worth seeing when you are trying to work out what a server
  # answered, and no others. `from`, `to`, `participant`, `jid`, `recipient`
  # and `notify` are all either a patient's number or their name.
  @sketch_attrs ~w(type xmlns reason code class text count offline t)

  @sketch_children 3

  @doc """
  A short, printable, **redacted** summary of this stanza.

  ## Why this exists

  Every hypothesis about the post-deploy offline-sync stall died against a
  measurement, and each measurement cost a deploy — because the only readings
  available were counts. `stanzas: %{"iq" => 21}` says twenty-one IQs were
  answered and cannot say *which*, so "the server ignored our `digest`" and
  "the server answered it and something else is wrong" produce identical
  output. CranL answers with an HTML page on its logs API, so the log lines
  that would distinguish them are not reachable from anywhere.

  This turns the next hypothesis into a reading instead of a deploy.

  ## Redaction is the whole reason it is a function and not `inspect/1`

  The summary is served by an authenticated health endpoint, which means it
  leaves the machine. A stanza carries patient phone numbers in `from`, `to`,
  `participant` and `jid`, a patient's WhatsApp display name in `notify`, and
  a message body in its content — so the allowlist is over attribute *keys*,
  and content is never included at any depth. A denylist would be one new
  attribute away from publishing a phone number.

      iex> Whatsmeow.Binary.Node.sketch(%Whatsmeow.Binary.Node{
      ...>   tag: "iq",
      ...>   attrs: %{"type" => "result", "from" => "966501234567@s.whatsapp.net"},
      ...>   content: [%Whatsmeow.Binary.Node{tag: "list", attrs: %{"xmlns" => "blocklist"}}]
      ...> })
      "iq[type=result](list[xmlns=blocklist])"
  """
  @spec sketch(t()) :: String.t()
  def sketch(%__MODULE__{} = node) do
    node.tag <> attrs_of(node) <> children_of(node)
  end

  defp attrs_of(%__MODULE__{attrs: attrs}) do
    @sketch_attrs
    |> Enum.flat_map(fn key ->
      case Map.get(attrs, key) do
        nil -> []
        value -> ["#{key}=#{printable(value)}"]
      end
    end)
    |> case do
      [] -> ""
      pairs -> "[" <> Enum.join(pairs, ",") <> "]"
    end
  end

  defp children_of(%__MODULE__{content: children}) when is_list(children) do
    shown = Enum.take(children, @sketch_children)
    more = length(children) - length(shown)

    inner =
      shown
      |> Enum.map(&(&1.tag <> attrs_of(&1)))
      |> Enum.join(",")

    suffix = if more > 0, do: ",+#{more}", else: ""

    case inner <> suffix do
      "" -> ""
      body -> "(" <> body <> ")"
    end
  end

  defp children_of(%__MODULE__{}), do: ""

  # A JID can appear under an allowlisted key on some stanzas, and an integer
  # or boolean under others. Anything that is not a short plain word is
  # reduced to its type rather than printed.
  defp printable(value) when is_integer(value) or is_boolean(value), do: to_string(value)

  defp printable(value) when is_binary(value) do
    cond do
      String.contains?(value, "@") -> "<jid>"
      String.match?(value, ~r/^\d{7,}$/) -> "<num>"
      String.length(value) > 32 -> "<long>"
      true -> value
    end
  end

  defp printable(%{__struct__: _}), do: "<jid>"
  defp printable(_other), do: "<?>"
end
