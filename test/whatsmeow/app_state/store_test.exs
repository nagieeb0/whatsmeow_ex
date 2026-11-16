defmodule Whatsmeow.AppState.StoreTest do
  @moduledoc """
  The `Whatsmeow.AppState.Store` contract, run against **both** implementations.

  The Memory store is what most other tests use, so it must behave exactly like
  Postgres or those tests prove nothing; running one suite over both is how that is
  kept honest. The Postgres half needs the test database (like the other DB tests:
  `mix ecto.create && mix ecto.migrate` with `MIX_ENV=test`).
  """
  use ExUnit.Case, async: false

  alias Ecto.Adapters.SQL
  alias Whatsmeow.AppState.Store.{Memory, Postgres}
  alias Whatsmeow.Repo

  @zero <<0::1024>>

  for {label, store} <- [{"Memory", Memory}, {"Postgres", Postgres}] do
    describe label do
      @store store

      setup do
        jid = fresh_jid(@store)
        %{s: @store, jid: jid}
      end

      test "keys: a missing key is :not_found, not an error", %{s: s, jid: jid} do
        assert :not_found = s.get_key(jid, <<1, 2, 3>>)
        assert :none = s.latest_key_id(jid)
      end

      test "keys: round trip, including an empty fingerprint", %{s: s, jid: jid} do
        :ok = s.put_key(jid, <<1>>, %{data: <<9::256>>, fingerprint: <<>>, timestamp: 10})
        assert {:ok, %{data: <<9::256>>, fingerprint: <<>>, timestamp: 10}} = s.get_key(jid, <<1>>)
      end

      test "keys: only a NEWER timestamp replaces an existing key (sqlstore's WHERE clause)", %{
        s: s,
        jid: jid
      } do
        :ok = s.put_key(jid, <<1>>, %{data: "old", fingerprint: "f1", timestamp: 10})
        :ok = s.put_key(jid, <<1>>, %{data: "stale", fingerprint: "f2", timestamp: 5})
        assert {:ok, %{data: "old", timestamp: 10}} = s.get_key(jid, <<1>>)

        :ok = s.put_key(jid, <<1>>, %{data: "same-ts", fingerprint: "f3", timestamp: 10})

        assert {:ok, %{data: "old"}} = s.get_key(jid, <<1>>),
               "equal timestamp does not replace either"

        :ok = s.put_key(jid, <<1>>, %{data: "new", fingerprint: "f4", timestamp: 11})
        assert {:ok, %{data: "new", fingerprint: "f4", timestamp: 11}} = s.get_key(jid, <<1>>)
      end

      test "keys: the latest key is the one with the newest timestamp", %{s: s, jid: jid} do
        :ok = s.put_key(jid, <<1>>, %{data: "a", fingerprint: "", timestamp: 100})
        :ok = s.put_key(jid, <<2>>, %{data: "b", fingerprint: "", timestamp: 300})
        :ok = s.put_key(jid, <<3>>, %{data: "c", fingerprint: "", timestamp: 200})
        assert {:ok, <<2>>} = s.latest_key_id(jid)
      end

      test "version: a collection never synced is version 0 with a zero hash", %{s: s, jid: jid} do
        assert {:ok, 0, @zero} = s.get_version(jid, "regular_low")
      end

      test "apply_patch_state sets version + hash", %{s: s, jid: jid} do
        hash = :crypto.strong_rand_bytes(128)
        :ok = s.apply_patch_state(jid, "regular_low", 7, hash, [], [])
        assert {:ok, 7, ^hash} = s.get_version(jid, "regular_low")

        # Other collections are independent.
        assert {:ok, 0, @zero} = s.get_version(jid, "regular_high")
      end

      test "reset_collection forgets the version AND every mutation MAC, of that collection only",
           %{s: s, jid: jid} do
        :ok =
          s.apply_patch_state(jid, "regular_low", 7, :crypto.strong_rand_bytes(128), [], [
            {<<1>>, "low"}
          ])

        :ok =
          s.apply_patch_state(jid, "regular_high", 2, :crypto.strong_rand_bytes(128), [], [
            {<<1>>, "high"}
          ])

        :ok = s.reset_collection(jid, "regular_low")

        assert {:ok, 0, @zero} = s.get_version(jid, "regular_low")

        assert :not_found = s.get_mutation_mac(jid, "regular_low", <<1>>),
               "a stale MAC would be subtracted from a hash that never held it"

        assert {:ok, 2, _} = s.get_version(jid, "regular_high")
        assert {:ok, "high"} = s.get_mutation_mac(jid, "regular_high", <<1>>)
      end

      test "mutation MACs: stored at a version, read back by index", %{s: s, jid: jid} do
        :ok =
          s.apply_patch_state(jid, "regular_low", 1, @zero, [], [{<<1>>, <<10>>}, {<<2>>, <<20>>}])

        assert {:ok, <<10>>} = s.get_mutation_mac(jid, "regular_low", <<1>>)
        assert {:ok, <<20>>} = s.get_mutation_mac(jid, "regular_low", <<2>>)
        assert :not_found = s.get_mutation_mac(jid, "regular_low", <<3>>)

        assert :not_found = s.get_mutation_mac(jid, "regular_high", <<1>>),
               "scoped to the collection"
      end

      test "mutation MACs: a later SET of the same index wins (highest version)", %{s: s, jid: jid} do
        :ok = s.apply_patch_state(jid, "regular_low", 1, @zero, [], [{<<1>>, "v1"}])
        :ok = s.apply_patch_state(jid, "regular_low", 2, @zero, [], [{<<1>>, "v2"}])
        assert {:ok, "v2"} = s.get_mutation_mac(jid, "regular_low", <<1>>)
      end

      test "mutation MACs: removal deletes EVERY version of the index", %{s: s, jid: jid} do
        :ok =
          s.apply_patch_state(jid, "regular_low", 1, @zero, [], [{<<1>>, "v1"}, {<<2>>, "keep"}])

        :ok = s.apply_patch_state(jid, "regular_low", 2, @zero, [], [{<<1>>, "v2"}])
        :ok = s.apply_patch_state(jid, "regular_low", 3, @zero, [<<1>>], [])

        assert :not_found = s.get_mutation_mac(jid, "regular_low", <<1>>)
        assert {:ok, "keep"} = s.get_mutation_mac(jid, "regular_low", <<2>>)
      end

      test "mutation MACs: within one call removal runs before insertion (REMOVE then SET)", %{
        s: s,
        jid: jid
      } do
        :ok = s.apply_patch_state(jid, "regular_low", 1, @zero, [], [{<<1>>, "old"}])
        :ok = s.apply_patch_state(jid, "regular_low", 2, @zero, [<<1>>], [{<<1>>, "new"}])
        assert {:ok, "new"} = s.get_mutation_mac(jid, "regular_low", <<1>>)
      end

      test "mutation MACs: a duplicate index in one batch does not error; the last wins", %{
        s: s,
        jid: jid
      } do
        :ok =
          s.apply_patch_state(jid, "regular_low", 1, @zero, [], [
            {<<1>>, "first"},
            {<<1>>, "second"}
          ])

        assert {:ok, "second"} = s.get_mutation_mac(jid, "regular_low", <<1>>)
      end

      test "a big snapshot (12 000 MACs) goes through in chunks", %{s: s, jid: jid} do
        added = for n <- 1..12_000, do: {<<n::32>>, <<n::256>>}
        assert :ok = s.apply_patch_state(jid, "regular_low", 1, @zero, [], added)
        assert {:ok, <<12_000::256>>} = s.get_mutation_mac(jid, "regular_low", <<12_000::32>>)
        assert {:ok, <<1::256>>} = s.get_mutation_mac(jid, "regular_low", <<1::32>>)

        assert :ok =
                 s.apply_patch_state(
                   jid,
                   "regular_low",
                   2,
                   @zero,
                   Enum.map(added, &elem(&1, 0)),
                   []
                 )

        assert :not_found = s.get_mutation_mac(jid, "regular_low", <<5::32>>)
      end

      test "accounts are isolated from each other", %{s: s, jid: jid} do
        other = fresh_jid(s)
        :ok = s.put_key(jid, <<1>>, %{data: "mine", fingerprint: "", timestamp: 1})
        :ok = s.apply_patch_state(jid, "regular_low", 4, @zero, [], [{<<1>>, "mine"}])

        assert :not_found = s.get_key(other, <<1>>)
        assert :none = s.latest_key_id(other)
        assert {:ok, 0, @zero} = s.get_version(other, "regular_low")
        assert :not_found = s.get_mutation_mac(other, "regular_low", <<1>>)
      end
    end
  end

  describe "Postgres only" do
    setup do
      %{jid: fresh_jid(Postgres)}
    end

    test "apply_patch_state is atomic: a failure midway leaves the old version, not half a patch",
         %{jid: jid} do
      hash = :crypto.strong_rand_bytes(128)
      :ok = Postgres.apply_patch_state(jid, "regular_low", 1, hash, [], [{<<1>>, "kept"}])

      # A NULL value MAC violates the column constraint on the insert step — after
      # the version row has already been written inside the transaction.
      assert {:error, _} =
               Postgres.apply_patch_state(
                 jid,
                 "regular_low",
                 2,
                 :crypto.strong_rand_bytes(128),
                 [<<1>>],
                 [{<<2>>, nil}]
               )

      assert {:ok, 1, ^hash} = Postgres.get_version(jid, "regular_low"),
             "version must not have advanced"

      assert {:ok, "kept"} = Postgres.get_mutation_mac(jid, "regular_low", <<1>>),
             "the removal must have been rolled back"
    end

    test "a stored hash of the wrong length is refused rather than guessed at", %{jid: jid} do
      SQL.query!(
        Repo,
        "INSERT INTO whatsmeow_app_state_version (jid, name, version, hash) VALUES ($1, 'regular_low', 3, $2)",
        [jid, <<1, 2, 3>>]
      )

      assert {:error, {:bad_hash_length, 3}} = Postgres.get_version(jid, "regular_low")
    end

    test "without a Repo every call is {:error, :no_store} and nothing raises" do
      stop_supervised(Repo)
      assert {:error, :no_store} = Postgres.get_version("x", "regular_low")

      assert {:error, :no_store} =
               Postgres.put_key("x", <<1>>, %{data: "a", fingerprint: "", timestamp: 1})

      assert {:error, :no_store} = Postgres.apply_patch_state("x", "n", 1, @zero, [], [])
    end

    # Keys and versions go with the device through the FK. The MACs table has no FK
    # and `delete_device/1` filters it on a column it does not have (`our_jid`; it is
    # `jid`) — an `:undefined_column` it then tolerates — so those rows survive. That
    # is not asserted here (it is a bug, not a contract); `reset_collection/2`, which
    # `Sync` runs before every snapshot, is what makes it harmless to this feature.
    test "deleting the device cascades to keys and versions", %{jid: jid} do
      :ok = Postgres.put_key(jid, <<1>>, %{data: "k", fingerprint: "", timestamp: 1})
      :ok = Postgres.apply_patch_state(jid, "regular_low", 1, @zero, [], [])

      assert :ok = Whatsmeow.Store.Postgres.delete_device(jid)

      assert :not_found = Postgres.get_key(jid, <<1>>)
      assert {:ok, 0, @zero} = Postgres.get_version(jid, "regular_low")
    end
  end

  # --- helpers ----------------------------------------------------------------

  defp fresh_jid(Memory) do
    if is_nil(Process.whereis(Memory)), do: start_supervised!(Memory)
    "#{System.unique_integer([:positive])}@s.whatsapp.net"
  end

  # The key and version tables reference the device row, so the Postgres store
  # needs a real device. Mirrors `DeleteDeviceTest`: promote a fresh device's
  # placeholder JID with raw SQL (`Schemas.Device.changeset/2` wants adv details
  # only a finished handshake has).
  defp fresh_jid(Postgres) do
    if is_nil(Process.whereis(Repo)), do: start_supervised!({Repo, pool_size: 2})
    _ = SQL.Sandbox.checkout(Repo)

    {:ok, device} =
      Whatsmeow.Store.Postgres.new_device(client_id: "as-#{System.unique_integer([:positive])}")

    jid = "#{System.unique_integer([:positive])}@s.whatsapp.net"
    SQL.query!(Repo, "UPDATE whatsmeow_device SET jid = $1 WHERE jid = $2", [jid, device.jid])
    jid
  end
end
