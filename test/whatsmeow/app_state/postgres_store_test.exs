defmodule Whatsmeow.AppState.Store.PostgresTest do
  @moduledoc """
  The Postgres adapter — what a host with a database runs — on the tables the
  schema migration creates, and the whole archive flow on top of it.
  """
  use ExUnit.Case, async: false

  alias Ecto.Adapters.SQL
  alias WAWebProtobufSyncAction, as: SA
  alias Whatsmeow.AppState
  alias Whatsmeow.AppState.{Hash, KeyStore}
  alias Whatsmeow.AppState.Store.Postgres
  alias Whatsmeow.AppStateFake, as: Fake
  alias Whatsmeow.Repo

  setup do
    start_supervised!({Repo, pool_size: 2})
    :ok = SQL.Sandbox.checkout(Repo)

    jid = "#{System.unique_integer([:positive])}.0:1@s.whatsapp.net"

    # The key and version tables reference the device row.
    SQL.query!(
      Repo,
      """
      INSERT INTO whatsmeow_device
        (jid, registration_id, noise_key, identity_key, signed_pre_key,
         signed_pre_key_id, signed_pre_key_sig, adv_key, adv_details,
         adv_account_sig, adv_account_sig_key, adv_device_sig,
         platform, business_name, push_name)
      VALUES ($1, 1, $2, $2, $2, 1, $2, $2, $2, $2, $2, $2, '', '', '')
      """,
      [jid, <<0>>]
    )

    %{jid: jid}
  end

  test "keys: newer timestamp wins, latest by timestamp", %{jid: jid} do
    key = fn data, ts -> %{key_data: data, fingerprint: <<8, 1>>, timestamp: ts} end

    assert {:error, :not_found} = Postgres.latest_sync_key_id(jid)
    assert :ok = Postgres.put_sync_key(jid, <<1>>, key.("one", 10))
    assert :ok = Postgres.put_sync_key(jid, <<2>>, key.("two", 20))
    assert :ok = Postgres.put_sync_key(jid, <<1>>, key.("older", 5))
    assert :ok = Postgres.put_sync_key(jid, <<2>>, key.("newer", 30))

    assert {:ok, %{key_data: "one", timestamp: 10, fingerprint: <<8, 1>>}} =
             Postgres.get_sync_key(jid, <<1>>)

    assert {:ok, %{key_data: "newer"}} = Postgres.get_sync_key(jid, <<2>>)
    assert {:ok, <<2>>} = Postgres.latest_sync_key_id(jid)
    assert {:error, :not_found} = Postgres.get_sync_key(jid, <<3>>)
  end

  test "version, hash and mutation MACs", %{jid: jid} do
    assert {:ok, %Hash{version: 0}} = Postgres.get_version(jid, "regular_low")

    h1 = %Hash{version: 3, hash: :binary.copy(<<1>>, 128)}
    added = [{"i1", "v1"}, {"i2", "v2"}, {"i1", "v1-later"}]
    assert :ok = Postgres.store_patch(jid, "regular_low", h1, [], added, [])
    assert {:ok, ^h1} = Postgres.get_version(jid, "regular_low")
    # Two SETs of one index in one patch: the later is the live value.
    assert {:ok, "v1-later"} = Postgres.get_mutation_mac(jid, "regular_low", "i1")

    h2 = %Hash{version: 4, hash: :binary.copy(<<2>>, 128)}
    assert :ok = Postgres.store_patch(jid, "regular_low", h2, ["i2"], [{"i1", "v1-v4"}], [])
    assert {:ok, nil} = Postgres.get_mutation_mac(jid, "regular_low", "i2")
    # Newest version wins, as Go's ORDER BY version DESC LIMIT 1.
    assert {:ok, "v1-v4"} = Postgres.get_mutation_mac(jid, "regular_low", "i1")
    # Collections are separate.
    assert {:ok, nil} = Postgres.get_mutation_mac(jid, "regular", "i1")

    # A snapshot replaces everything that was stored for the collection.
    h3 = %Hash{version: 9, hash: :binary.copy(<<3>>, 128)}
    assert :ok = Postgres.store_patch(jid, "regular_low", h3, [], [{"i3", "v3"}], reset?: true)
    assert {:ok, nil} = Postgres.get_mutation_mac(jid, "regular_low", "i1")
    assert {:ok, "v3"} = Postgres.get_mutation_mac(jid, "regular_low", "i3")

    assert :ok = Postgres.delete_version(jid, "regular_low")
    assert {:ok, %Hash{version: 0}} = Postgres.get_version(jid, "regular_low")
  end

  test "a snapshot larger than one insert batch", %{jid: jid} do
    added = for i <- 1..1000, do: {<<i::32>>, <<i::256>>}
    assert :ok = Postgres.store_patch(jid, "critical_unblock_low", %Hash{version: 1}, [], added, [])
    assert {:ok, <<777::256>>} = Postgres.get_mutation_mac(jid, "critical_unblock_low", <<777::32>>)
  end

  test "archive then mark read, end to end on Postgres", %{jid: jid} do
    fake = Fake.start()
    {:ok, [_]} = KeyStore.put_key_share(jid, Fake.key_share(fake), store: Postgres)

    pin = %SA.SyncActionValue{pinAction: %SA.PinAction{pinned: true}}
    Fake.phone_write(fake, "regular_low", [{:set, ["pin_v1", "1234567890@s.whatsapp.net"], pin, 5}])
    Fake.take_snapshot(fake, "regular_low")
    Fake.phone_write(fake, "regular_low", [{:remove, ["pin_v1", "1234567890@s.whatsapp.net"], 5}])

    ctx = Fake.context(fake, jid, Postgres)
    assert :ok = AppState.archive_chat(ctx, "1234567890", true)
    assert :ok = AppState.mark_chat_as_read(ctx, "1234567890", true)

    assert [{:accepted, _}, {:accepted, _}] = Fake.get(fake).sends
    head = Fake.head(fake, "regular_low")
    assert {:ok, ^head} = Postgres.get_version(jid, "regular_low")
  end
end
