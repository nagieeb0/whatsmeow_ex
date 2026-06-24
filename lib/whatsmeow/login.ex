defmodule Whatsmeow.Login do
  @moduledoc """
  Post-handshake login decoder for an already-paired device.

  After the Noise XX handshake completes, a device whose `ClientPayload`
  was a `login_payload` (numeric WA JID) gets exactly one of three
  responses as the first inbound binary-XML stanza:

  * `<success ... lid="user.0:N@lid" t="1715000000">` — authenticated. The
    `t` attribute is the server's clock; we surface it as a signed
    `server_time_offset` (server seconds − local seconds) so callers can
    correct future timestamps without a second `Time.utc_now/0` call.
  * `<failure reason="…" code="…" />` — login refused (account locked,
    device removed remotely, etc).
  * `<stream:error code="…" />` followed by `<xmlstreamend />` — server
    bailed before authentication (usually a `ClientPayload`/version
    mismatch).

  This module has **no I/O**. The caller drives the socket and feeds us
  the parsed `%Node{}`; we tell it which case applies and pack the
  useful fields into `Login.Result`.

  Mirrors `whatsmeow-main/connectionevents.go#handleConnectSuccess`. The
  pre-key refresh, LID-save side effects, and privacy-token expiry that
  Go's handler does inline belong on the GenServer side (Phase 9 wire
  glue), not here.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Types.JID

  defmodule Result do
    @moduledoc "Parsed `<success>` outcome — the data the Session needs to bind a logged-in connection."
    @enforce_keys [:lid, :server_time_offset]
    defstruct [:lid, :server_time_offset]

    @type t :: %__MODULE__{
            lid: String.t() | nil,
            server_time_offset: integer() | nil
          }
  end

  @typedoc """
  Failure surfaces. Stream-level errors and explicit `<failure>` IQs are
  distinct so the caller can decide whether to retry (stream errors —
  often transient) or give up (failure — usually terminal).
  """
  @type error ::
          :unexpected_node
          | {:stream_error, String.t() | nil}
          | {:failure, String.t() | nil, String.t() | nil}

  @doc """
  Classify the first post-handshake inbound node. Returns:

  * `{:ok, %Result{}}` for `<success>`,
  * `{:error, {:stream_error, code}}` for `<stream:error>`,
  * `{:error, {:failure, reason, code}}` for `<failure>`,
  * `{:error, :unexpected_node}` otherwise.
  """
  @spec parse_first_node(Node.t()) :: {:ok, Result.t()} | {:error, error()}
  def parse_first_node(%Node{tag: "success"} = node) do
    {:ok,
     %Result{
       lid: lid_attr(node),
       server_time_offset: server_time_offset(node)
     }}
  end

  def parse_first_node(%Node{tag: "stream:error"} = node) do
    {:error, {:stream_error, attr_str(node, "code")}}
  end

  def parse_first_node(%Node{tag: "failure"} = node) do
    {:error, {:failure, attr_str(node, "reason"), attr_str(node, "code")}}
  end

  def parse_first_node(%Node{}), do: {:error, :unexpected_node}

  # --- helpers --------------------------------------------------------------

  # The server may set `lid` as either a string or a parsed JID (the binary
  # decoder coerces attrs typed as JIDs). Normalize both to the canonical
  # `user.agent:device@server` string.
  defp lid_attr(%Node{} = node) do
    case Node.attr(node, "lid") do
      nil -> nil
      "" -> nil
      %JID{} = j -> JID.to_string(j)
      bin when is_binary(bin) -> bin
      _ -> nil
    end
  end

  defp server_time_offset(%Node{} = node) do
    case attr_str(node, "t") do
      nil ->
        nil

      t when is_binary(t) ->
        case Integer.parse(t) do
          {n, _} -> n - System.system_time(:second)
          :error -> nil
        end
    end
  end

  defp attr_str(%Node{} = node, key) do
    case Node.attr(node, key) do
      nil -> nil
      "" -> nil
      bin when is_binary(bin) -> bin
      n when is_integer(n) -> Integer.to_string(n)
      _ -> nil
    end
  end
end
