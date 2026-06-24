defmodule Whatsmeow.WAVersionTest do
  # NOT async — `:persistent_term` is global state and concurrent tests
  # would race each other.
  use ExUnit.Case, async: false

  alias Whatsmeow.WAVersion

  setup do
    # Each test starts from a known cache state.
    WAVersion.clear_cache()
    on_exit(fn -> WAVersion.clear_cache() end)
    :ok
  end

  describe "parse_revision/1" do
    test "extracts revision from a representative HTML snippet" do
      html = ~s|<html>...{"foo":"bar","client_revision":1057981,"baz":42}...</html>|
      assert {:ok, 1_057_981} = WAVersion.parse_revision(html)
    end

    test "matches even when surrounded by JS minification noise" do
      html =
        ~s|var c={"WA_BUILD":42,"client_revision":99999999,"BUILD_HASH":"abc"};window.AppConfig=c;|

      assert {:ok, 99_999_999} = WAVersion.parse_revision(html)
    end

    test "returns :revision_not_found when the field is missing" do
      assert {:error, :revision_not_found} = WAVersion.parse_revision("hello world")
      assert {:error, :revision_not_found} = WAVersion.parse_revision("")
    end

    test "returns :revision_not_found when the value is non-numeric" do
      assert {:error, :revision_not_found} =
               WAVersion.parse_revision(~s|"client_revision":"oops",|)
    end
  end

  describe ":persistent_term cache" do
    test "cached/0 returns the default when nothing is cached" do
      assert WAVersion.cached() == WAVersion.default_version()
    end

    test "put_cached/1 round-trips" do
      WAVersion.put_cached({2, 3000, 1_999_999})
      assert WAVersion.cached() == {2, 3000, 1_999_999}
    end

    test "clear_cache/0 reverts to default" do
      WAVersion.put_cached({2, 3000, 12345})
      assert WAVersion.cached() == {2, 3000, 12345}

      WAVersion.clear_cache()
      assert WAVersion.cached() == WAVersion.default_version()
    end

    test "refresh/1 does NOT touch the cache on fetch failure" do
      # Point at a closed loopback port to force a connect error.
      WAVersion.put_cached({2, 3000, 7777})

      result =
        WAVersion.fetch_latest(
          host: "127.0.0.1",
          port: 1,
          scheme: :http,
          timeout: 500
        )

      assert match?({:error, _}, result)
      # Cache survives.
      assert WAVersion.cached() == {2, 3000, 7777}
    end
  end

  describe "ClientPayload integration" do
    test "Whatsmeow.ClientPayload.wa_version/0 reflects the cached value" do
      WAVersion.put_cached({2, 3000, 8_675_309})
      assert Whatsmeow.ClientPayload.wa_version() == {2, 3000, 8_675_309}
    end

    test "wa_version_hash/0 recomputes when the cache changes" do
      WAVersion.put_cached({2, 3000, 1})
      h1 = Whatsmeow.ClientPayload.wa_version_hash()

      WAVersion.put_cached({2, 3000, 2})
      h2 = Whatsmeow.ClientPayload.wa_version_hash()

      assert h1 != h2
      assert byte_size(h1) == 16
      assert byte_size(h2) == 16
    end
  end

  describe "fetch_latest/1 with Bypass" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "scrapes the revision from a 200 response", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/", fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          ~s|<!doctype html><script>var x={"client_revision":1058001,"foo":1};</script>|
        )
      end)

      assert {:ok, {2, 3000, 1_058_001}} =
               WAVersion.fetch_latest(
                 host: "127.0.0.1",
                 port: bypass.port,
                 scheme: :http,
                 timeout: 2_000
               )
    end

    test "returns {:error, {:http_status, …}} on non-200", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/", fn conn ->
        Plug.Conn.resp(conn, 503, "")
      end)

      assert {:error, {:http_status, 503}} =
               WAVersion.fetch_latest(
                 host: "127.0.0.1",
                 port: bypass.port,
                 scheme: :http,
                 timeout: 2_000
               )
    end

    test "refresh/1 caches on success", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/", fn conn ->
        Plug.Conn.resp(conn, 200, ~s|prelude;"client_revision":4242,;postlude|)
      end)

      assert {:ok, {2, 3000, 4242}} =
               WAVersion.refresh(
                 host: "127.0.0.1",
                 port: bypass.port,
                 scheme: :http,
                 timeout: 2_000
               )

      assert WAVersion.cached() == {2, 3000, 4242}
    end

    test "refresh/1 does not cache on parse failure", %{bypass: bypass} do
      WAVersion.put_cached({2, 3000, 1111})

      Bypass.expect_once(bypass, "GET", "/", fn conn ->
        Plug.Conn.resp(conn, 200, "no revision here")
      end)

      assert {:error, :revision_not_found} =
               WAVersion.refresh(
                 host: "127.0.0.1",
                 port: bypass.port,
                 scheme: :http,
                 timeout: 2_000
               )

      assert WAVersion.cached() == {2, 3000, 1111}
    end
  end
end
