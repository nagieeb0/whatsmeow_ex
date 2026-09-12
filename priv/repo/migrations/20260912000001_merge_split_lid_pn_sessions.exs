defmodule Whatsmeow.Repo.Migrations.MergeSplitLidPnSessions do
  @moduledoc """
  Fold the duplicate Signal records one device accumulated while WhatsApp was
  migrating it from phone-number addressing to LID.

  Before `Whatsmeow.Signal.Address` existed, the inbound path filed a session
  under whatever `from=` said (often the LID) and the outbound path filed it
  under the phone number the device list returned. One physical device, two
  ratchets — and the peer, which keeps exactly one, could not decrypt anything
  we sent on the other. The visible symptom was the recipient's phone stuck on
  "waiting for this message" while their laptop read the same reply fine.

  The code now canonicalises to LID everywhere, so this only has to clean up
  what the old code wrote.

  ## The rule, and why it is not symmetric

  Where both rows exist, **the LID row wins and the PN row is deleted.** It is
  not a coin toss: the LID row is the one the peer's phone has been talking on,
  which is exactly why the PN row still carries an unanswered `pending_pre_key`
  and kept re-sending `pkmsg`. Moving the PN row over the LID one would install
  the broken half and keep the bug.

  Where only the PN row exists, it is renamed to the LID key, preserving the
  device suffix — a session is per device, not per person.

  ## Down

  Irreversible by design. The inverse is not "move it back": the two rows held
  different ratchet state and one of them was deleted because it was wrong.
  Re-splitting them would recreate the defect. A peer whose row is missing
  re-establishes via X3DH on the next message, which is the correct recovery.
  """

  use Ecto.Migration

  @tables ["whatsmeow_sessions", "whatsmeow_identity_keys"]

  def up, do: fold!(repo())

  @doc """
  The whole migration, against an explicit repo.

  Public and repo-parameterised so a test can exercise it directly. Driving it
  through `Ecto.Migrator` instead would take the migrator's advisory lock,
  which deadlocks against the sandbox transaction a test already holds.
  """
  def fold!(repo) do
    # Ecto runs migrations inside a transaction; everything below is one unit.
    seed_own_device_mapping(repo)

    map = lid_map(repo)

    Enum.each(@tables, fn table ->
      table
      |> rows(repo)
      |> Enum.each(&fold_row(repo, table, &1, map))
    end)
  end

  def down do
    :ok
  end

  # --- the work -------------------------------------------------------------

  # Our own device is in `whatsmeow_device` under both names already, but never
  # made it into the mapping table — so the copies we send to our own other
  # devices would have stayed on the phone-number key while every peer moved.
  defp seed_own_device_mapping(repo) do
    repo.query!(
      """
      INSERT INTO whatsmeow_lid_map (lid, pn)
      SELECT #{bare_sql("d.lid")} || '@lid', #{bare_sql("d.jid")} || '@s.whatsapp.net'
        FROM whatsmeow_device d
       WHERE d.lid IS NOT NULL AND d.lid <> ''
         AND d.jid IS NOT NULL AND d.jid <> ''
      ON CONFLICT (lid) DO NOTHING
      """,
      []
    )
  end

  defp lid_map(repo) do
    %{rows: rows} = repo.query!("SELECT pn, lid FROM whatsmeow_lid_map", [])

    Map.new(rows, fn [pn, lid] -> {bare(pn), bare(lid)} end)
  end

  defp rows(table, repo) do
    %{rows: rows} =
      repo.query!(
        "SELECT our_jid, their_id FROM #{table} WHERE their_id LIKE '%@s.whatsapp.net'",
        []
      )

    rows
  end

  defp fold_row(repo, table, [our_jid, their_id], map) do
    case Map.fetch(map, bare(their_id)) do
      {:ok, lid_user} ->
        target = lid_user <> device_suffix(their_id) <> "@lid"

        if exists?(repo, table, our_jid, target) do
          repo.query!(
            "DELETE FROM #{table} WHERE our_jid = $1 AND their_id = $2",
            [our_jid, their_id]
          )
        else
          repo.query!(
            "UPDATE #{table} SET their_id = $1 WHERE our_jid = $2 AND their_id = $3",
            [target, our_jid, their_id]
          )
        end

      :error ->
        # No mapping known for this peer. Leaving the row on the phone-number
        # key is correct: `Whatsmeow.Signal.Address` passes unmapped peers
        # through unchanged, so the session is still found.
        :ok
    end
  end

  defp exists?(repo, table, our_jid, their_id) do
    %{num_rows: n} =
      repo.query!(
        "SELECT 1 FROM #{table} WHERE our_jid = $1 AND their_id = $2 LIMIT 1",
        [our_jid, their_id]
      )

    n > 0
  end

  # --- JID string surgery ---------------------------------------------------
  #
  # Deliberately self-contained rather than calling `Whatsmeow.Types.JID`: a
  # migration has to keep meaning the same thing years after the modules it
  # was written beside have moved on.

  # "966511792082:15@s.whatsapp.net" -> "966511792082"
  # "447400000000.0:1@s.whatsapp.net" -> "447400000000"
  defp bare(jid) when is_binary(jid) do
    jid
    |> String.split("@", parts: 2)
    |> hd()
    |> String.split(":", parts: 2)
    |> hd()
    |> String.split(".", parts: 2)
    |> hd()
  end

  # ":15" for a companion device, "" for the primary. Agent is dropped with the
  # server: a LID JID renders `user:device@lid`, never `user.agent:device@lid`.
  defp device_suffix(jid) when is_binary(jid) do
    case jid |> String.split("@", parts: 2) |> hd() |> String.split(":", parts: 2) do
      [_user, device] when device != "" -> ":" <> device
      _ -> ""
    end
  end

  defp bare_sql(column) do
    "split_part(split_part(split_part(#{column}, '@', 1), ':', 1), '.', 1)"
  end
end
