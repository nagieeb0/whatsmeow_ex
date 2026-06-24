#!/usr/bin/env elixir

# Reproduces what `Imdent.WhatsApp.ensure_session/1` does, but only against
# whatsmeow_ex's own supervision tree (no Imdent app noise). Surfaces
# whether the bug is in the Session OTP wrapper vs the underlying lib.
#
#   mix run --no-halt scripts/smoke_session.exs

require Logger

# 1. Fresh WA version.
case Whatsmeow.WAVersion.refresh(timeout: 30_000) do
  {:ok, v} -> IO.puts(">>> WA version: #{inspect(v)}")
  {:error, r} -> IO.puts(">>> WA version refresh FAILED: #{inspect(r)} — using cached/default")
end

# 2. Ephemeral device, same as the working smoke CLI — bypasses Store
#    so this standalone script doesn't need a migrated lib-side DB.
#    The OTP path under test is Session GenServer + drain + dispatch.
alias Whatsmeow.Crypto.{Curve25519, XEdDSA}
alias Whatsmeow.Store.Schemas.Device

{_, noise} = Curve25519.generate_keypair()
{_, ident} = Curve25519.generate_keypair()
{spk_pub, spk} = Curve25519.generate_keypair()
spk_sig = XEdDSA.sign(ident, <<5, spk_pub::binary>>)

client_id = "smoke_session_#{System.unique_integer([:positive])}"

device = %Device{
  jid: client_id,
  client_id: client_id,
  registration_id: :rand.uniform(0xFFFFFFFF),
  noise_key: noise,
  identity_key: ident,
  signed_pre_key: spk,
  signed_pre_key_id: 1,
  signed_pre_key_sig: spk_sig,
  adv_key: :crypto.strong_rand_bytes(32),
  adv_details: <<>>,
  adv_account_sig: :crypto.strong_rand_bytes(64),
  adv_account_sig_key: :crypto.strong_rand_bytes(32),
  adv_device_sig: :crypto.strong_rand_bytes(64)
}

IO.puts(">>> client_id = #{client_id}")
IO.puts(">>> ephemeral device built (no DB persist)")

# 3. Subscribe BEFORE start_session so no event races us.
:ok = Whatsmeow.Notifications.subscribe(client_id)
IO.puts(">>> subscribed to PubSub topic for #{client_id}")

# 4. Start the Session GenServer (same as Whatsmeow.start_session).
{:ok, pid} = Whatsmeow.start_session(device)
IO.puts(">>> Session GenServer started: #{inspect(pid)}")

# 5. Kick off the connect AND immediately cast a second :connect — this
#    is what the LV path produces when the user clicks Connect twice
#    or when Autostart.resume_now fires concurrently with the LV click.
#    Before the fix this orphaned the first socket; QR frames belonged
#    to the old conn and got silently dropped.
:ok = Whatsmeow.Session.connect(pid)
:ok = Whatsmeow.Session.connect(pid)
:ok = Whatsmeow.Session.connect(pid)
IO.puts(">>> three :connect casts sent (race simulation) — waiting for events...")

# 6. Print every event with elapsed-ms.
defmodule Drain do
  def loop(start) do
    receive do
      {:whatsmeow, event} ->
        dt = System.monotonic_time(:millisecond) - start
        tag = event.__struct__ |> Module.split() |> List.last()

        suffix =
          case event do
            %Whatsmeow.Types.Events.QR{code: c} ->
              " code=#{String.slice(c || "", 0, 40)}..."

            %Whatsmeow.Types.Events.Disconnected{reason: r} ->
              " reason=#{inspect(r)}"

            %Whatsmeow.Types.Events.PairError{reason: r} ->
              " reason=#{inspect(r)}"

            %Whatsmeow.Types.Events.PairSuccess{jid: j, business_name: b} ->
              " jid=#{inspect(j)} biz=#{inspect(b)}"

            _ ->
              ""
          end

        IO.puts("  [+#{dt}ms] #{tag}#{suffix}")
        loop(start)

      other ->
        IO.puts("  [other] #{inspect(other, limit: 4)}")
        loop(start)
    after
      180_000 ->
        IO.puts(">>> 180s timeout — exiting.")
    end
  end
end

Drain.loop(System.monotonic_time(:millisecond))
