defmodule Whatsmeow.Store.LidMergeMigrationTest do
  @moduledoc """
  The one-shot migration that folds the duplicate Signal rows one device
  accumulated while WhatsApp migrated it from phone-number to LID addressing.

  Runs the real migration module against seeded splits, inside the sandbox
  transaction, so the string surgery it carries its own copy of is actually
  exercised rather than assumed.
  """

  use ExUnit.Case, async: false

  alias Ecto.Adapters.SQL
  alias Whatsmeow.Repo

  @migration Whatsmeow.Repo.Migrations.MergeSplitLidPnSessions

  @our "201068010145:41@s.whatsapp.net"
  @pn "966511792082@s.whatsapp.net"
  @lid "132680784040127@lid"

  setup_all do
    # Migrations live in `priv` as `.exs` and are never compiled into the app,
    # so the module has to be loaded before `Ecto.Migrator` can call it.
    Code.require_file("priv/repo/migrations/20260912000001_merge_split_lid_pn_sessions.exs")
    :ok
  end

  setup do
    start_supervised!({Repo, pool_size: 2})
    :ok = SQL.Sandbox.checkout(Repo)

    SQL.query!(Repo, "DELETE FROM whatsmeow_sessions", [])
    SQL.query!(Repo, "DELETE FROM whatsmeow_lid_map", [])
    SQL.query!(Repo, "DELETE FROM whatsmeow_device", [])

    # `whatsmeow_sessions.our_jid` is a foreign key onto the device row.
    put_device(@our, "184142562087139:41@lid")

    :ok
  end

  defp put_device(jid, lid) do
    SQL.query!(
      Repo,
      """
      INSERT INTO whatsmeow_device
        (jid, lid, registration_id, noise_key, identity_key, signed_pre_key,
         signed_pre_key_id, signed_pre_key_sig, adv_key, adv_details,
         adv_account_sig, adv_account_sig_key, adv_device_sig,
         platform, business_name, push_name, lid_migration_ts)
      VALUES ($1, $2, 1, $3, $3, $3, 1, $3, $3, $3, $3, $3, $3, '', '', '', 0)
      """,
      [jid, lid, <<0>>]
    )
  end

  defp put_session(their_id, blob) do
    SQL.query!(
      Repo,
      "INSERT INTO whatsmeow_sessions (our_jid, their_id, session) VALUES ($1, $2, $3)",
      [@our, their_id, blob]
    )
  end

  defp sessions do
    %{rows: rows} =
      SQL.query!(Repo, "SELECT their_id, session FROM whatsmeow_sessions ORDER BY their_id", [])

    Map.new(rows, fn [their_id, blob] -> {their_id, blob} end)
  end

  defp migrate! do
    # `apply/3`, not a direct call: the migration is an `.exs` loaded at
    # runtime in `setup_all`, so a compile-time reference warns that the module
    # does not exist yet.
    apply(@migration, :fold!, [Repo])
  end

  test "where both rows exist the LID row survives and the phone-number row goes" do
    :ok = Whatsmeow.LIDMap.put(@lid, @pn)
    put_session(@lid, "live-lid-ratchet")
    put_session(@pn, "wedged-pn-ratchet")

    migrate!()

    after_ = sessions()

    assert Map.keys(after_) == [@lid]

    # Direction matters. The LID row is the one the peer's phone has been
    # talking on; moving the phone-number row over it would install the broken
    # half and keep the bug.
    assert after_[@lid] == "live-lid-ratchet"
  end

  test "where only the phone-number row exists it is renamed, keeping the device" do
    :ok = Whatsmeow.LIDMap.put(@lid, @pn)
    put_session("966511792082:15@s.whatsapp.net", "companion-15")
    put_session("966511792082:17@s.whatsapp.net", "companion-17")

    migrate!()

    after_ = sessions()

    assert Map.keys(after_) == ["132680784040127:15@lid", "132680784040127:17@lid"]
    assert after_["132680784040127:15@lid"] == "companion-15"
    assert after_["132680784040127:17@lid"] == "companion-17"
  end

  test "a peer with no mapping is left alone" do
    put_session("201000000000@s.whatsapp.net", "untouched")

    migrate!()

    assert sessions() == %{"201000000000@s.whatsapp.net" => "untouched"}
  end

  test "rows already on the LID key are not touched twice" do
    :ok = Whatsmeow.LIDMap.put(@lid, @pn)
    put_session(@lid, "already-canonical")

    migrate!()

    assert sessions() == %{@lid => "already-canonical"}
  end

  test "our own device is seeded into the mapping so its sessions move too" do
    # `whatsmeow_device` carries both names already, but nothing ever wrote them
    # to the mapping table — so the copies we send to our own other devices
    # would have stayed on the phone-number key while every peer moved.
    put_session("201068010145:38@s.whatsapp.net", "our-own-companion")

    migrate!()

    assert Map.keys(sessions()) == ["184142562087139:38@lid"]
  end
end
