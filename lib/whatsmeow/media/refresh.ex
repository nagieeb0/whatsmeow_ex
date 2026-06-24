defmodule Whatsmeow.Media.Refresh do
  @moduledoc """
  IQ-driven refresh of the `%Whatsmeow.Media.Conn{}` cache.

  WhatsApp won't accept a media upload (or a directPath-based download)
  without a current auth token + host list. The server hands these out
  in response to a `<iq xmlns="w:m" type="set"><media_conn/></iq>` — same
  query used by Go's `refreshMediaConn`.

  Ports `whatsmeow-main/mediaconn.go`.

  ## Response shape

      <iq type="result">
        <media_conn auth="…" ttl="3600" auth_ttl="21600" max_buckets="12">
          <host hostname="mmg.whatsapp.net" .../>
          <host hostname="media-fra3-1.cdn.whatsapp.net" .../>
          ...
        </media_conn>
      </iq>
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Media.Conn
  alias Whatsmeow.Session

  @server_jid "s.whatsapp.net"

  @typedoc "Reasons refresh can fail."
  @type error :: :missing_media_conn | :missing_hosts | {:iq, term()} | term()

  @doc """
  Request a fresh `%Conn{}` from the server through `server`.

  `server` is a Session pid (or device_id string for the registered
  name). Blocks for the round-trip up to `timeout` ms.
  """
  @spec refresh(pid() | String.t(), non_neg_integer()) :: {:ok, Conn.t()} | {:error, error()}
  def refresh(server, timeout \\ 30_000) do
    iq = build_query_iq()

    case Session.send_iq(server, iq, timeout) do
      {:ok, %Node{} = response} -> parse(response)
      {:error, reason} -> {:error, {:iq, reason}}
    end
  end

  @doc """
  Build the `<iq xmlns="w:m" type="set"><media_conn/></iq>` query.

  Public so tests can build the node without hitting Session.
  """
  @spec build_query_iq(String.t() | nil) :: Node.t()
  def build_query_iq(id \\ nil) do
    Node.new(
      "iq",
      %{
        "id" => id || IQ.generate_id(),
        "to" => @server_jid,
        "type" => "set",
        "xmlns" => "w:m"
      },
      [Node.new("media_conn", %{}, nil)]
    )
  end

  @doc """
  Parse a `<iq type="result">` response into a `%Conn{}`.

  Returns `{:error, :missing_media_conn}` if the IQ doesn't carry a
  `<media_conn>` child, `{:error, :missing_hosts}` if it does but has
  no `<host>` children.
  """
  @spec parse(Node.t()) :: {:ok, Conn.t()} | {:error, error()}
  def parse(%Node{} = iq) do
    case Node.get_child(iq, "media_conn") do
      %Node{} = mc ->
        hosts =
          mc
          |> Node.get_children("host")
          |> Enum.map(&Node.attr(&1, "hostname"))
          |> Enum.reject(&(is_nil(&1) or &1 == ""))

        if hosts == [] do
          {:error, :missing_hosts}
        else
          {:ok,
           %Conn{
             auth: Node.attr(mc, "auth"),
             auth_ttl: parse_int(Node.attr(mc, "auth_ttl")),
             ttl: parse_int(Node.attr(mc, "ttl")),
             max_buckets: parse_int(Node.attr(mc, "max_buckets")),
             fetched_at: DateTime.utc_now(),
             hosts: hosts
           }}
        end

      _ ->
        {:error, :missing_media_conn}
    end
  end

  defp parse_int(nil), do: nil
  defp parse_int(n) when is_integer(n), do: n

  defp parse_int(s) when is_binary(s) do
    case Integer.parse(s) do
      {n, _} -> n
      :error -> nil
    end
  end
end
