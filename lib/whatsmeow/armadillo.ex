defmodule Whatsmeow.Armadillo do
  @moduledoc """
  WhatsApp Armadillo SubProtocol envelope codec.

  Ports `whatsmeow-main/proto/armadilloutil/decode.go` and the
  `decodeArmadillo` dispatcher from
  `whatsmeow-main/armadillomessage.go`.

  An Armadillo envelope (`waCommon.SubProtocol`) is a versioned wrapper:

      {payload :: binary, version :: int32}

  This module owns the version-check + sub-protocol routing logic. The
  protobuf marshalling of inner messages remains in the generated proto
  layer (Phase 3); here we operate on raw payload bytes.
  """

  defmodule Envelope do
    @moduledoc """
    A SubProtocol envelope — versioned binary payload.
    """
    defstruct [:payload, :version]

    @type t :: %__MODULE__{payload: binary(), version: integer()}
  end

  @typedoc """
  Known application payload versions (from
  `waMsgTransport.{FB,IG}MessageApplicationVersion`).
  """
  @type version :: :fb | :ig | integer()

  @fb_version 1
  @ig_version 5

  @doc "FB application payload version constant."
  def fb_version, do: @fb_version

  @doc "Instagram application payload version constant."
  def ig_version, do: @ig_version

  @doc """
  Marshal a payload into an envelope tagged with `version`.

  `version` accepts either an integer or one of `:fb`, `:ig` for the
  named constants.
  """
  @spec marshal(binary(), version()) :: Envelope.t()
  def marshal(payload, version) when is_binary(payload) do
    %Envelope{payload: payload, version: resolve_version(version)}
  end

  @doc """
  Unmarshal an envelope, checking that `version` matches `expected`.

  Returns `{:ok, payload}` on success, or one of:

    * `{:error, {:unsupported_version, got, expected}}`
    * `{:error, :missing_payload}`
  """
  @spec unmarshal(Envelope.t(), version()) ::
          {:ok, binary()} | {:error, term()}
  def unmarshal(%Envelope{payload: nil}, _), do: {:error, :missing_payload}

  def unmarshal(%Envelope{payload: payload, version: got}, expected) do
    want = resolve_version(expected)

    if got == want do
      {:ok, payload}
    else
      {:error, {:unsupported_version, got, want}}
    end
  end

  @doc """
  Dispatch on a top-level Armadillo transport's application version.

  Given a `MessageTransport` already partially decoded into the map
  `%{application_payload: %Envelope{}}`, route to the FB or IG decoder
  by inspecting the version field. Returns a tagged tuple suitable for
  pattern-matching by higher-level handlers.
  """
  @spec route(Envelope.t()) :: {:fb, binary()} | {:ig, binary()} | {:error, term()}
  def route(%Envelope{version: @fb_version, payload: payload}), do: {:fb, payload}
  def route(%Envelope{version: @ig_version, payload: payload}), do: {:ig, payload}

  def route(%Envelope{version: v}),
    do: {:error, {:unsupported_version, v, [:fb, :ig]}}

  defp resolve_version(:fb), do: @fb_version
  defp resolve_version(:ig), do: @ig_version
  defp resolve_version(n) when is_integer(n), do: n
end
