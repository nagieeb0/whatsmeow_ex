defmodule Whatsmeow.Transport.WebSocket.MintProxyTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Transport.WebSocket.Mint, as: MintWS

  describe "parse_proxy/1" do
    test "nil → empty opts" do
      assert {:ok, []} = MintWS.parse_proxy(nil)
    end

    test "{host, port} shorthand expands to an :http proxy" do
      assert {:ok, [proxy: {:http, "10.0.0.1", 8080, []}]} =
               MintWS.parse_proxy({"10.0.0.1", 8080})
    end

    test "3-tuple keeps the explicit scheme" do
      assert {:ok, [proxy: {:https, "proxy.example", 443, []}]} =
               MintWS.parse_proxy({:https, "proxy.example", 443})
    end

    test "4-tuple is passed through verbatim" do
      mint_opts = [transport_opts: [verify: :verify_none]]

      assert {:ok, [proxy: {:http, "proxy.example", 8080, ^mint_opts}]} =
               MintWS.parse_proxy({:http, "proxy.example", 8080, mint_opts})
    end

    test "http URL parses host + port" do
      assert {:ok, [proxy: {:http, "proxy.example", 8080, []}]} =
               MintWS.parse_proxy("http://proxy.example:8080")
    end

    test "https URL parses scheme + host + port" do
      assert {:ok, [proxy: {:https, "secure-proxy.example", 8443, []}]} =
               MintWS.parse_proxy("https://secure-proxy.example:8443")
    end

    test "URL with userinfo emits a Basic Proxy-Authorization header" do
      {:ok, opts} = MintWS.parse_proxy("http://alice:secret@proxy.example:8080")

      assert opts[:proxy] == {:http, "proxy.example", 8080, []}
      assert [{"proxy-authorization", "Basic " <> b64}] = opts[:proxy_headers]
      assert Base.decode64!(b64) == "alice:secret"
    end

    test "malformed URL returns {:error, :bad_proxy_url}" do
      assert {:error, :bad_proxy_url} = MintWS.parse_proxy("not a url")
    end

    test "unsupported types return {:error, :bad_proxy_spec}" do
      assert {:error, :bad_proxy_spec} = MintWS.parse_proxy(42)
      assert {:error, :bad_proxy_spec} = MintWS.parse_proxy(%{})
    end
  end
end
