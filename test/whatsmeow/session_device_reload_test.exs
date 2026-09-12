defmodule Whatsmeow.SessionDeviceReloadTest do
  @moduledoc """
  A restarted session must come back with the device the STORE holds, not the
  one baked into its child spec.

  `Whatsmeow.start_session/2` puts the `%Device{}` into the spec it hands
  `DynamicSupervisor`, and a supervisor restarts a child from the spec it was
  originally given. Pairing writes the adv credentials to the store — it
  cannot reach back into that spec. So before this, a crash after pairing
  restarted the session from a pre-pairing snapshot: no login payload, the
  server answered with `<pair-device>`, and the user was asked to scan a fresh
  QR while a perfectly good paired device sat in the database.

  Observed downstream (imdent, 2026-08-12): a killed session emitted QR codes
  for 11+ minutes with `adv_account_sig` present in the row the whole time.
  """
  use ExUnit.Case, async: false

  alias Whatsmeow.Session
  alias Whatsmeow.Store.Schemas.Device

  @client_id "clinic_c13d7f80"
  @paired_jid "201068010145:30@s.whatsapp.net"

  defmodule PairedStore do
    @moduledoc false
    # Only the two lookups `reload_device/2` uses. Not the full behaviour —
    # it is reached through `Whatsmeow.Store.impl/0`, never by dispatch.
    def get_device_by_client_id("clinic_c13d7f80"),
      do:
        {:ok,
         %Whatsmeow.Store.Schemas.Device{
           client_id: "clinic_c13d7f80",
           jid: "201068010145:30@s.whatsapp.net",
           adv_account_sig: <<1, 2, 3>>
         }}

    def get_device_by_client_id(_), do: {:error, :not_found}

    def get_device("201068010145:30@s.whatsapp.net"),
      do:
        {:ok,
         %Whatsmeow.Store.Schemas.Device{
           client_id: "clinic_c13d7f80",
           jid: "201068010145:30@s.whatsapp.net",
           adv_account_sig: <<1, 2, 3>>
         }}

    def get_device(_), do: {:error, :not_found}
  end

  defmodule EmptyStore do
    @moduledoc false
    def get_device_by_client_id(_), do: {:error, :not_found}
    def get_device(_), do: {:error, :not_found}
  end

  defmodule BrokenStore do
    @moduledoc false
    def get_device_by_client_id(_), do: raise("store is down")
    def get_device(_), do: raise("store is down")
  end

  defp with_store(mod, fun) do
    previous = Application.get_env(:whatsmeow_ex, :store)
    Application.put_env(:whatsmeow_ex, :store, mod)

    try do
      fun.()
    after
      if previous,
        do: Application.put_env(:whatsmeow_ex, :store, previous),
        else: Application.delete_env(:whatsmeow_ex, :store)
    end
  end

  # The spec the supervisor is holding: captured before pairing, so the jid is
  # still the placeholder and there are no adv credentials.
  defp stale_snapshot, do: %Device{client_id: @client_id, jid: @client_id}

  test "a restart reloads the paired device by client_id, discarding the stale snapshot" do
    with_store(PairedStore, fn ->
      {:ok, state, {:continue, :connect}} =
        Session.init(device_id: @client_id, device: stale_snapshot())

      assert state.device.jid == @paired_jid,
             "restarted from the child spec's pre-pairing snapshot — this is the " <>
               "bug that made a crashed session demand a fresh QR scan"

      assert state.device.adv_account_sig, "came back without the pairing credentials"
      assert state.device_id == @client_id, "registry key must not change"
    end)
  end

  test "also resolves when the session is keyed by jid rather than client_id" do
    # `Whatsmeow.start_session/2`'s `session_key/1` falls back to `:jid`, so a
    # host that supplies no client_id still gets the reload.
    with_store(PairedStore, fn ->
      {:ok, state, {:continue, :connect}} =
        Session.init(device_id: @paired_jid, device: stale_snapshot())

      assert state.device.jid == @paired_jid
    end)
  end

  test "keeps the passed device when the store has nothing — a genuinely new device" do
    with_store(EmptyStore, fn ->
      snapshot = stale_snapshot()
      {:ok, state} = Session.init(device_id: @client_id, device: snapshot)

      assert state.device == snapshot,
             "a first-ever start must still work; there is nothing to reload yet"
    end)
  end

  test "a store that is down does not stop the session from booting" do
    # Falling back to the snapshot is exactly the old behaviour, so a store
    # outage degrades to what shipped before rather than refusing to start.
    with_store(BrokenStore, fn ->
      snapshot = stale_snapshot()
      {:ok, state} = Session.init(device_id: @client_id, device: snapshot)
      assert state.device == snapshot
    end)
  end

  # A paired device dials itself, and an unpaired one must not.
  #
  # The second half is the one with teeth. This process is `:permanent`, so it
  # is restarted after every crash; if an unpaired device auto-dialled, every
  # boot would open a pairing socket for every clinic that has not got round to
  # pairing, forever.
  describe "dialing on boot" do
    test "a paired device asks to connect, and starts idle until it does" do
      with_store(PairedStore, fn ->
        {:ok, state, {:continue, :connect}} =
          Session.init(device_id: @client_id, device: stale_snapshot())

        assert state.status == :idle
        assert state.reconnect_attempts == 0
        assert state.failure_retries == 0
      end)
    end

    test "an unpaired device does not dial" do
      with_store(EmptyStore, fn ->
        assert {:ok, %{status: :idle}} =
                 Session.init(device_id: @client_id, device: stale_snapshot())
      end)
    end

    test "offline mode never dials, paired or not" do
      with_store(PairedStore, fn ->
        assert {:ok, %{offline?: true}} =
                 Session.init(device_id: @client_id, device: stale_snapshot(), offline?: true)
      end)
    end

    test "a session started with auto_reconnect? false never dials" do
      with_store(PairedStore, fn ->
        assert {:ok, %{auto_reconnect?: false}} =
                 Session.init(
                   device_id: @client_id,
                   device: stale_snapshot(),
                   auto_reconnect?: false
                 )
      end)
    end
  end
end
