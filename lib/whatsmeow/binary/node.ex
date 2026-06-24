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
end
