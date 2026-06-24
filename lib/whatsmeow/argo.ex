defmodule Whatsmeow.Argo do
  @moduledoc """
  Facebook Argo wire format — a self-describing typed-binary serializer
  used by WhatsApp for some newer query paths (Newsletters, Armadillo).

  Ports `whatsmeow-main/argo/argo.go` and the subset of
  `github.com/beeper/argo-go` that WhatsApp uses.

  ## Sub-modules

  * `Whatsmeow.Argo.Varint` — ULEB128 + ZigZag integer codec
  * `Whatsmeow.Argo.Label` — sentinel-aware signed varints
  * `Whatsmeow.Argo.Wire` — wire-type tags
  * `Whatsmeow.Argo.SelfDescribing` — read self-describing values
  * `Whatsmeow.Argo.SelfDescribingEncoder` — write self-describing values
  * `Whatsmeow.Argo.Store` — query-id ↔ message-name lookup

  The vendored data files live in `priv/argo/`.
  """

  alias Whatsmeow.Argo.{SelfDescribing, SelfDescribingEncoder, Store}

  @doc """
  Returns the path to the wire-type definitions on disk.
  """
  @spec wire_type_store_path() :: Path.t()
  def wire_type_store_path,
    do: Application.app_dir(:whatsmeow_ex, ["priv", "argo", "argo-wire-type-store.argo"])

  @doc "Encode a value in self-describing Argo wire format."
  defdelegate encode(value), to: SelfDescribingEncoder

  @doc "Decode a self-describing Argo payload."
  defdelegate decode(bin), to: SelfDescribing

  @doc "Look up the query id for a WhatsApp Argo message name."
  defdelegate query_id_for_name(name), to: Store

  @doc "Look up the message name for a WhatsApp Argo query id."
  defdelegate name_for_query_id(id), to: Store
end
