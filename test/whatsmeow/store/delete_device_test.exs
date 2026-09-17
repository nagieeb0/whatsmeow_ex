defmodule Whatsmeow.Store.DeleteDeviceTest do
  @moduledoc """
  "I un-paired and paired again and it still does not work."

  `delete_device/1` exists to stop a re-pair inheriting Signal state from
  before the delete — its own comment explains that the new device gets a fresh
  identity key and noise key while a surviving `whatsmeow_sessions` row still
  references the old chain, so the first outbound envelope is undecryptable.

  It never did it. Three bugs in a row:

    1. The cascade included `DELETE FROM whatsmeow_lid_map WHERE our_jid = $1`,
       and that table has no `our_jid` column — it is keyed on `lid`/`pn`.
    2. Postgres raised `:undefined_column`, which was not in the rescue's
       tolerated set, so it called `Repo.rollback/1`.
    3. The `Repo.transaction/1` result was discarded and `:ok` returned
       unconditionally.

  So every session, identity key, pre-key and sender key survived the delete
  and the caller was told it had worked. Unreportable, because nothing failed.
  """
  use ExUnit.Case, async: false

  alias Ecto.Adapters.SQL
  alias Whatsmeow.Repo
  alias Whatsmeow.Store.Postgres

  # `config/test.exs` sets `start_repo?: false`, so a test that needs the
  # database starts it itself — the same shape `LidMergeMigrationTest` uses.
  setup do
    start_supervised!({Repo, pool_size: 2})
    :ok = SQL.Sandbox.checkout(Repo)
    :ok
  end

  # The JID is set with raw SQL rather than through the changeset: pairing is
  # what normally writes it, and `Schemas.Device.changeset/2` requires
  # `adv_details` — which a device that has never completed a handshake does
  # not have. This test is about the delete, not about pairing.
  # `Schemas.Device`'s primary key is the JID, so that is also what
  # `delete_device/1` and `get_device/1` take. A fresh device carries a
  # placeholder JID until pairing rewrites it; this promotes it to a real one
  # with raw SQL, because `Schemas.Device.changeset/2` requires `adv_details`
  # that only a completed handshake produces, and this test is about the
  # delete rather than about pairing.
  defp device do
    client_id = "test-#{System.unique_integer([:positive])}"
    {:ok, device} = Postgres.new_device(client_id: client_id)

    jid = "#{System.unique_integer([:positive])}@s.whatsapp.net"

    SQL.query!(Repo, "UPDATE whatsmeow_device SET jid = $1 WHERE jid = $2", [jid, device.jid])

    {:ok, device} = Postgres.get_device(jid)
    device
  end

  test "it actually deletes the Signal state, which is the whole point" do
    device = device()

    :ok = Postgres.put_session(device.jid, "peer@lid", "session-bytes")
    :ok = Postgres.put_identity(device.jid, "peer@lid", :crypto.strong_rand_bytes(32))
    :ok = Postgres.put_pre_key(device.jid, 1, "pre-key-bytes", false)

    assert {:ok, _} = Postgres.get_session(device.jid, "peer@lid")

    assert :ok = Postgres.delete_device(device.jid)

    assert {:error, :not_found} = Postgres.get_session(device.jid, "peer@lid"),
           "a surviving session row is the stale ratchet a re-pair inherits"

    assert {:error, :not_found} = Postgres.get_identity(device.jid, "peer@lid")
    assert {:error, :not_found} = Postgres.get_pre_key(device.jid, 1)
  end

  test "and the device row itself" do
    device = device()

    assert :ok = Postgres.delete_device(device.jid)
    assert {:error, :not_found} = Postgres.get_device(device.jid)
  end

  # One device's delete must not take another's state with it.
  test "and only that device's" do
    mine = device()
    theirs = device()

    :ok = Postgres.put_session(mine.jid, "peer@lid", "mine")
    :ok = Postgres.put_session(theirs.jid, "peer@lid", "theirs")

    assert :ok = Postgres.delete_device(mine.jid)

    assert {:ok, "theirs"} = Postgres.get_session(theirs.jid, "peer@lid")
  end

  test "a device that is not there is an error, not a silent success" do
    assert {:error, :not_found} = Postgres.delete_device("nobody@s.whatsapp.net")
  end
end
