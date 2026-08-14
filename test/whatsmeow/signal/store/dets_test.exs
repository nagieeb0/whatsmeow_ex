defmodule Whatsmeow.Signal.Store.DETSTest do
  use ExUnit.Case, async: false

  alias Whatsmeow.Signal.Store.Adapter
  alias Whatsmeow.Signal.Store.DETS
  alias Whatsmeow.Signal.{GroupSession, Session}

  setup do
    dir = Path.join(System.tmp_dir!(), "whatsmeow_dets_test_#{System.unique_integer([:positive])}")
    Application.put_env(:whatsmeow_ex, :signal_store_dir, dir)
    Application.put_env(:whatsmeow_ex, :signal_store, DETS)
    DETS.close()

    on_exit(fn ->
      DETS.close()
      Application.delete_env(:whatsmeow_ex, :signal_store)
      Application.delete_env(:whatsmeow_ex, :signal_store_dir)
      File.rm_rf(dir)
    end)

    %{dir: dir}
  end

  test "a session survives a round-trip through disk" do
    session = %Session{root_key: :binary.copy(<<1>>, 32)}

    assert :ok = Adapter.save_session("me@s.whatsapp.net", "you@s.whatsapp.net", session)
    assert {:ok, loaded} = Adapter.load_session("me@s.whatsapp.net", "you@s.whatsapp.net")
    assert loaded.root_key == session.root_key
  end

  test "a session survives the table being closed and reopened" do
    session = %Session{root_key: :binary.copy(<<7>>, 32)}
    :ok = Adapter.save_session("me@s.whatsapp.net", "you@s.whatsapp.net", session)

    # Simulates a restart: the sync on write is what makes this pass.
    DETS.close()

    assert {:ok, loaded} = Adapter.load_session("me@s.whatsapp.net", "you@s.whatsapp.net")
    assert loaded.root_key == session.root_key
  end

  test "an unknown session is :not_found, not an error" do
    assert Adapter.load_session("me@s.whatsapp.net", "nobody@s.whatsapp.net") == :not_found
  end

  test "sessions are keyed by both sides, not just the peer" do
    :ok = Adapter.save_session("a@s.whatsapp.net", "x@s.whatsapp.net", %Session{root_key: <<1>>})
    :ok = Adapter.save_session("b@s.whatsapp.net", "x@s.whatsapp.net", %Session{root_key: <<2>>})

    assert {:ok, %{root_key: <<1>>}} = Adapter.load_session("a@s.whatsapp.net", "x@s.whatsapp.net")
    assert {:ok, %{root_key: <<2>>}} = Adapter.load_session("b@s.whatsapp.net", "x@s.whatsapp.net")
  end

  test "group sender keys round-trip too" do
    gs = GroupSession.new(42)

    assert :ok = Adapter.save_sender_key("me@s.whatsapp.net", "g@g.us", "them@s.whatsapp.net", gs)

    assert {:ok, loaded} =
             Adapter.load_sender_key("me@s.whatsapp.net", "g@g.us", "them@s.whatsapp.net")

    assert loaded.id == gs.id
  end

  test "sender keys are keyed by chat as well as sender" do
    :ok = Adapter.save_sender_key("me@x", "g1@g.us", "them@x", GroupSession.new(1))

    assert Adapter.load_sender_key("me@x", "g2@g.us", "them@x") == :not_found
  end

  test "the adapter reports itself available without any Repo" do
    assert Adapter.impl() == DETS
    assert Adapter.available?()
  end

  # Sessions and sender keys alone are not enough to run: steady-state decrypt
  # also needs the peer's identity key, and a first-contact pkmsg needs the
  # one-time prekey it names. An adapter missing either is unusable on its own,
  # which is the state this one shipped in before these were wired.
  describe "the rest of what decryption needs" do
    test "peer identity keys round-trip" do
      pub = :binary.copy(<<9>>, 32)

      assert :ok = Adapter.save_identity("me@s.whatsapp.net", "you@s.whatsapp.net", pub)
      assert Adapter.load_identity("me@s.whatsapp.net", "you@s.whatsapp.net") == pub
    end

    test "an unknown identity is nil, not a crash" do
      assert Adapter.load_identity("me@s.whatsapp.net", "nobody@s.whatsapp.net") == nil
    end

    test "a non-32-byte identity is refused rather than stored" do
      assert :ok = Adapter.save_identity("me@x", "you@x", <<1, 2, 3>>)
      assert Adapter.load_identity("me@x", "you@x") == nil
    end

    test "prekeys round-trip and are retrievable by the id a pkmsg names" do
      keys = [
        %{key_id: 1, priv: :binary.copy(<<1>>, 32)},
        %{key_id: 2, priv: :binary.copy(<<2>>, 32)}
      ]

      assert :ok = Adapter.save_prekeys("me@s.whatsapp.net", keys)
      assert Adapter.load_prekey("me@s.whatsapp.net", 2) == :binary.copy(<<2>>, 32)
      assert Adapter.load_prekey("me@s.whatsapp.net", 99) == nil
    end

    test "unuploaded prekeys come back lowest id first and respect the limit" do
      keys = for id <- [5, 1, 3], do: %{key_id: id, priv: :binary.copy(<<id>>, 32)}
      :ok = Adapter.save_prekeys("me@s.whatsapp.net", keys)

      assert [%{key_id: 1}, %{key_id: 3}] = Adapter.load_unuploaded_prekeys("me@s.whatsapp.net", 2)
    end

    test "max_prekey_id/1 is what the next generation counts from" do
      assert Adapter.max_prekey_id("me@s.whatsapp.net") == 0

      :ok = Adapter.save_prekeys("me@s.whatsapp.net", [%{key_id: 7, priv: :binary.copy(<<7>>, 32)}])

      assert Adapter.max_prekey_id("me@s.whatsapp.net") == 7
    end

    test "marking uploaded removes them from the unuploaded pool but keeps them readable" do
      keys = for id <- 1..4, do: %{key_id: id, priv: :binary.copy(<<id>>, 32)}
      :ok = Adapter.save_prekeys("me@s.whatsapp.net", keys)

      assert {:ok, 2} = Adapter.mark_prekeys_uploaded("me@s.whatsapp.net", 2)

      assert [%{key_id: 3}, %{key_id: 4}] =
               Adapter.load_unuploaded_prekeys("me@s.whatsapp.net", 10)

      # Still loadable — an uploaded prekey is exactly the one a peer will name.
      assert Adapter.load_prekey("me@s.whatsapp.net", 1) == :binary.copy(<<1>>, 32)
    end

    test "prekeys are scoped per account" do
      :ok = Adapter.save_prekeys("a@s.whatsapp.net", [%{key_id: 1, priv: :binary.copy(<<1>>, 32)}])

      assert Adapter.load_prekey("b@s.whatsapp.net", 1) == nil
      assert Adapter.max_prekey_id("b@s.whatsapp.net") == 0
    end

    test "get_or_generate/2 tops up the pool with no database at all" do
      assert {:ok, keys} = Whatsmeow.PreKeys.get_or_generate("me@s.whatsapp.net", 5)
      assert length(keys) == 5
      assert Enum.map(keys, & &1.key_id) == [1, 2, 3, 4, 5]

      # Second call reuses the pool rather than generating a second batch.
      assert {:ok, again} = Whatsmeow.PreKeys.get_or_generate("me@s.whatsapp.net", 5)
      assert Enum.map(again, & &1.key_id) == [1, 2, 3, 4, 5]
      assert Adapter.max_prekey_id("me@s.whatsapp.net") == 5
    end

    test "get_or_generate/2 continues the id sequence after an upload" do
      {:ok, _} = Whatsmeow.PreKeys.get_or_generate("me@s.whatsapp.net", 3)
      {:ok, 3} = Whatsmeow.PreKeys.mark_uploaded("me@s.whatsapp.net", 3)

      assert {:ok, fresh} = Whatsmeow.PreKeys.get_or_generate("me@s.whatsapp.net", 2)
      assert Enum.map(fresh, & &1.key_id) == [4, 5]
    end
  end
end
