defmodule Whatsmeow.SendBundleBatchTest do
  @moduledoc """
  One prekey `<iq>` for a whole fanout, indexed by device.

  ## Why the index is the risky part

  `fetch_prekey_bundle/3` asked for one JID at a time and picked the answer with
  `pick_bundle/2`, whose `jids_match?/2` compares **the user part alone**. That
  is correct when a response concerns one device and silently wrong the moment
  it concerns four of the same person's — which is exactly what batching makes
  routine. A user-keyed index would hand every device of an account the first
  device's bundle, and X3DH against the wrong bundle produces an envelope the
  recipient cannot open: a message that vanishes, with `{:ok, id}` returned.

  The second decision is the absent device. A companion that has been unlinked
  is not named in the response at all, and treating "not named" as "not asked"
  would send it back down the per-device path for a round trip that can only
  end in `:no_bundle` again.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.PreKeyBundle
  alias Whatsmeow.Send
  alias Whatsmeow.Types.JID

  defp pub, do: :crypto.strong_rand_bytes(32)
  defp sig, do: :crypto.strong_rand_bytes(64)

  defp user_node(jid, reg) do
    Node.new("user", %{"jid" => jid}, [
      Node.new("registration", %{}, <<reg::big-unsigned-32>>),
      Node.new("identity", %{}, pub()),
      Node.new("skey", %{}, [
        Node.new("id", %{}, <<1::big-unsigned-24>>),
        Node.new("value", %{}, pub()),
        Node.new("signature", %{}, sig())
      ])
    ])
  end

  defp iq(users), do: Node.new("iq", %{"type" => "result"}, [Node.new("list", %{}, users)])

  defp jid!(s) do
    {:ok, j} = JID.parse(s)
    j
  end

  test "four devices of one account get four different bundles" do
    peers = Enum.map(0..3, &jid!("201068010145:#{&1}@s.whatsapp.net"))

    response = iq(Enum.map(0..3, &user_node("201068010145:#{&1}@s.whatsapp.net", &1 + 100)))

    bundles = Send.bundles_from_response(peers, response)

    assert map_size(bundles) == 4

    registrations =
      bundles
      |> Map.values()
      |> Enum.map(fn %PreKeyBundle{registration_id: r} -> r end)
      |> Enum.sort()

    assert registrations == [100, 101, 102, 103],
           "a user-keyed index would collapse these to one repeated bundle"
  end

  test "a device the server did not name is :no_bundle, not missing" do
    live = jid!("201068010145:59@s.whatsapp.net")
    dead = jid!("201068010145:57@s.whatsapp.net")

    response = iq([user_node("201068010145:59@s.whatsapp.net", 1)])

    bundles = Send.bundles_from_response([live, dead], response)

    assert %PreKeyBundle{} = bundles[{"201068010145", 59}]
    assert bundles[{"201068010145", 57}] == {:error, :no_bundle}
  end

  test "a per-device server error stays a server error, not a no-bundle" do
    peer = jid!("201068010145:58@s.whatsapp.net")

    response =
      iq([
        Node.new("user", %{"jid" => "201068010145:58@s.whatsapp.net"}, [
          Node.new("error", %{"text" => "not-found"}, nil)
        ])
      ])

    bundles = Send.bundles_from_response([peer], response)

    # Not `:no_bundle` — that one is cached for fifteen minutes, and a transient
    # server error must not silence a live device for a quarter of an hour.
    assert {:error, {:server_error, _}} = bundles[{"201068010145", 58}]
  end

  test "a response in a shape we do not recognise says nothing about anybody" do
    peer = jid!("201068010145:59@s.whatsapp.net")

    assert Send.bundles_from_response([peer], Node.new("nonsense", %{}, nil)) == %{}
  end
end
