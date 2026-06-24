defmodule Whatsmeow.Media.RefreshTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Media.Refresh

  describe "build_query_iq/1" do
    test "produces <iq xmlns=w:m type=set><media_conn/></iq>" do
      iq = Refresh.build_query_iq("fixed-id")

      assert %Node{
               tag: "iq",
               attrs: %{
                 "id" => "fixed-id",
                 "to" => "s.whatsapp.net",
                 "type" => "set",
                 "xmlns" => "w:m"
               }
             } = iq

      assert [%Node{tag: "media_conn"}] = Node.children(iq)
    end
  end

  describe "parse/1" do
    test "happy path extracts hosts + auth + ttls" do
      iq =
        Node.new("iq", %{"type" => "result"}, [
          Node.new(
            "media_conn",
            %{
              "auth" => "AUTH123",
              "ttl" => "3600",
              "auth_ttl" => "21600",
              "max_buckets" => "12"
            },
            [
              Node.new("host", %{"hostname" => "mmg.whatsapp.net"}, nil),
              Node.new("host", %{"hostname" => "media-fra3-1.cdn.whatsapp.net"}, nil)
            ]
          )
        ])

      assert {:ok, conn} = Refresh.parse(iq)
      assert conn.auth == "AUTH123"
      assert conn.ttl == 3600
      assert conn.auth_ttl == 21600
      assert conn.max_buckets == 12
      assert conn.hosts == ["mmg.whatsapp.net", "media-fra3-1.cdn.whatsapp.net"]
      assert %DateTime{} = conn.fetched_at
    end

    test "missing media_conn child surfaces as :missing_media_conn" do
      iq = Node.new("iq", %{"type" => "result"}, [])
      assert {:error, :missing_media_conn} = Refresh.parse(iq)
    end

    test "media_conn with no hosts surfaces as :missing_hosts" do
      iq =
        Node.new("iq", %{"type" => "result"}, [
          Node.new("media_conn", %{"auth" => "X", "ttl" => "1"}, [])
        ])

      assert {:error, :missing_hosts} = Refresh.parse(iq)
    end
  end
end
