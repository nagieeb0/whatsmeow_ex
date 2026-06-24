defmodule Whatsmeow.Signal.Store.PostgresTest do
  use ExUnit.Case, async: false

  @moduletag :integration

  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Signal.{Session, Store}
  alias Whatsmeow.Store.Schemas

  # Live-Postgres test (requires a started Repo + migrated schema). Tagged
  # `:integration` so it doesn't run in the default suite.

  setup do
    on_exit(fn ->
      try do
        Whatsmeow.Repo.delete_all(Schemas.Session)
        Whatsmeow.Repo.delete_all(Schemas.Device)
      rescue
        _ -> :ok
      end
    end)

    :ok
  end

  defp synthetic_session do
    {pub, priv} = Curve25519.generate_keypair()

    %Session{
      dh_self: {pub, priv},
      dh_remote: :crypto.strong_rand_bytes(32),
      root_key: :crypto.strong_rand_bytes(32),
      sending_ck: :crypto.strong_rand_bytes(32),
      receiving_ck: :crypto.strong_rand_bytes(32),
      sending_n: 3,
      receiving_n: 7,
      previous_n: 1,
      skipped_keys: %{{:crypto.strong_rand_bytes(32), 0} => :crypto.strong_rand_bytes(32)}
    }
  end

  defp insert_owner_device(jid) do
    %Schemas.Device{}
    |> Schemas.Device.changeset(%{
      jid: jid,
      registration_id: 1,
      noise_key: :crypto.strong_rand_bytes(32),
      identity_key: :crypto.strong_rand_bytes(32),
      signed_pre_key: :crypto.strong_rand_bytes(32),
      signed_pre_key_id: 1,
      signed_pre_key_sig: :crypto.strong_rand_bytes(64),
      adv_key: :crypto.strong_rand_bytes(32),
      adv_details: <<>>,
      adv_account_sig: :crypto.strong_rand_bytes(64),
      adv_account_sig_key: :crypto.strong_rand_bytes(32),
      adv_device_sig: :crypto.strong_rand_bytes(64)
    })
    |> Whatsmeow.Repo.insert!()
  end

  test "put/3 + get/2 round-trip a Signal session through Postgres" do
    our_jid = "owner-#{System.unique_integer([:positive])}@s.whatsapp.net"
    their_id = "peer-#{System.unique_integer([:positive])}@s.whatsapp.net"
    sess = synthetic_session()
    insert_owner_device(our_jid)

    assert :ok = Store.Postgres.put(our_jid, their_id, sess)

    assert {:ok, loaded} = Store.Postgres.get(our_jid, their_id)
    assert loaded.root_key == sess.root_key
    assert loaded.sending_ck == sess.sending_ck
    assert loaded.receiving_ck == sess.receiving_ck
    assert loaded.sending_n == sess.sending_n
    assert loaded.receiving_n == sess.receiving_n
    assert loaded.dh_self == sess.dh_self
    assert loaded.skipped_keys == sess.skipped_keys
  end

  test "put/3 upserts on conflict (subsequent put overwrites)" do
    our_jid = "owner-#{System.unique_integer([:positive])}@s.whatsapp.net"
    their_id = "peer-#{System.unique_integer([:positive])}@s.whatsapp.net"
    sess1 = synthetic_session()
    sess2 = %Session{synthetic_session() | sending_n: 99}
    insert_owner_device(our_jid)

    assert :ok = Store.Postgres.put(our_jid, their_id, sess1)
    assert :ok = Store.Postgres.put(our_jid, their_id, sess2)

    assert {:ok, loaded} = Store.Postgres.get(our_jid, their_id)
    assert loaded.sending_n == 99
  end

  test "get/2 returns :not_found for an unknown pair" do
    assert :not_found = Store.Postgres.get("none@s.whatsapp.net", "none@s.whatsapp.net")
  end
end
