defmodule Whatsmeow.Signal.LockTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Signal.Lock

  # With no Repo running there is no concurrent writer to serialise against, so
  # the lock must degrade to a plain call — transparently. Swallowing or
  # rewriting the body's return value here would silently break every encrypt
  # and decrypt path, since both now run inside it.
  describe "without a Repo" do
    test "with_session/3 returns the body's value untouched" do
      assert Lock.with_session("me@s.whatsapp.net", "you@s.whatsapp.net", fn -> :hello end) ==
               :hello

      assert Lock.with_session("me@s.whatsapp.net", "you@s.whatsapp.net", fn ->
               {:ok, <<1, 2, 3>>, "msg", %{k: 1}}
             end) == {:ok, <<1, 2, 3>>, "msg", %{k: 1}}
    end

    test "with_sender_key/4 returns the body's value untouched" do
      assert Lock.with_sender_key("me@s.whatsapp.net", "g@g.us", "them@s.whatsapp.net", fn ->
               :group
             end) == :group
    end

    test "an exception in the body propagates rather than being turned into a value" do
      assert_raise RuntimeError, "boom", fn ->
        Lock.with_session("a@s.whatsapp.net", "b@s.whatsapp.net", fn -> raise "boom" end)
      end
    end
  end
end
