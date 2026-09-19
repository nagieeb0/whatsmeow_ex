defmodule Whatsmeow.Media.FinchTest do
  @moduledoc """
  The download this module exists to do, done.

  ## Why this file had to exist

  `collect_body/2` built a reducer that returns `{:cont, acc}` — the
  `Finch.stream_while/5` contract — and handed it to `Finch.stream/5`, which
  adds the `{:cont, _}` itself. The accumulator therefore nested one level per
  message and the first `{:data, _}` raised `BadMapError` against
  `{:cont, {:cont, %{status: 200, body: []}}}`.

  It failed on every host, for every voice note, every image and every history
  sync, from the day it shipped — and the suite did not notice, because nothing
  here had ever performed a download. A test asserting a body comes back whole
  is the smallest thing that would have caught it.
  """
  use ExUnit.Case, async: false

  alias Whatsmeow.Media.Finch, as: MediaFinch

  setup do
    start_supervised!({Finch, name: Whatsmeow.Finch})
    bypass = Bypass.open()
    {:ok, bypass: bypass, url: "http://localhost:#{bypass.port}/media"}
  end

  describe "collect_body/2" do
    test "returns the whole body, across several chunks", %{bypass: bypass, url: url} do
      # Three writes, so the reducer sees three `{:data, _}` messages — one is
      # not enough to prove anything about an accumulator that nests.
      Bypass.expect_once(bypass, "GET", "/media", fn conn ->
        conn = Plug.Conn.send_chunked(conn, 200)
        {:ok, conn} = Plug.Conn.chunk(conn, "one-")
        {:ok, conn} = Plug.Conn.chunk(conn, "two-")
        {:ok, conn} = Plug.Conn.chunk(conn, "three")
        conn
      end)

      assert {:ok, 200, iodata} = MediaFinch.collect_body(url)
      assert IO.iodata_to_binary(iodata) == "one-two-three"
    end

    test "reports a non-2xx status rather than raising", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "GET", "/media", fn conn ->
        Plug.Conn.resp(conn, 404, "gone")
      end)

      assert {:ok, 404, _iodata} = MediaFinch.collect_body(url)
    end

    test "returns a two-tuple error when the connection dies mid-transfer", %{
      bypass: bypass,
      url: url
    } do
      # `stream_while/5` reports failures as `{:error, reason, partial_acc}`.
      # `collect_body/2` must not hand that three-tuple on to `fetch_one/2`,
      # whose `case` has no clause for it.
      Bypass.down(bypass)

      assert {:error, reason} = MediaFinch.collect_body(url)
      refute match?({_, _, _}, reason)
    end
  end
end
