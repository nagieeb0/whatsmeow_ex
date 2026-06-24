defmodule Whatsmeow.Media.ConnTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Media.Conn

  test "expiry/1 adds ttl seconds to fetched_at" do
    c = %Conn{ttl: 3600, fetched_at: ~U[2026-05-11 12:00:00Z]}
    assert Conn.expiry(c) == ~U[2026-05-11 13:00:00Z]
  end

  test "expired?/2 is true at or past expiry" do
    c = %Conn{ttl: 60, fetched_at: ~U[2026-05-11 12:00:00Z]}

    refute Conn.expired?(c, ~U[2026-05-11 12:00:59Z])
    assert Conn.expired?(c, ~U[2026-05-11 12:01:00Z])
    assert Conn.expired?(c, ~U[2026-05-11 12:01:01Z])
  end

  test "url_for/2 picks first host with https" do
    c = %Conn{hosts: ["mmg.whatsapp.net", "fallback.cdn.whatsapp.net"]}

    assert Conn.url_for(c, "/mms/image/abcd?token=x") ==
             "https://mmg.whatsapp.net/mms/image/abcd?token=x"
  end

  test "all_urls/2 returns urls for every host" do
    c = %Conn{hosts: ["a.example", "b.example"]}

    assert Conn.all_urls(c, "/upload") == [
             "https://a.example/upload",
             "https://b.example/upload"
           ]
  end
end
