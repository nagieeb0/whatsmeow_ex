defmodule Whatsmeow.OwnAddressTest do
  @moduledoc """
  A device has two addresses and this library only ever knew one.

  `is_from_me?` compared the sender against the account's phone number.
  `Whatsmeow.Store.Schemas.Device` has carried a `lid` column since LID
  addressing arrived, and `session.ex` never read it — `rg "device\\.lid"` over
  that file returned nothing.

  Go checks both (`message.go:110`):

      if source.Sender.User == clientID.User || source.Sender.User == clientLID.User

  What it cost: `maybe_start_history_sync/3` opens with
  `with true <- info.is_from_me?`. A history-sync notification the server
  addressed from the account's own LID answered `false`, so no `hist_sync`
  receipt went out and no download started — and the bare `rescue _ -> :ok`
  below it meant not one line of log. The feature looked unimplemented for as
  long as anybody had looked.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.MessageInfo
  alias Whatsmeow.Types.JID

  @pn %JID{user: "966501234567", server: "s.whatsapp.net"}
  @lid %JID{user: "132680784040127", server: "lid"}

  defp message(from) do
    Node.new(
      "message",
      %{"id" => "M1", "from" => from, "t" => "1700000000"},
      [Node.new("enc", %{"type" => "msg"}, <<1, 2, 3>>)]
    )
  end

  test "a message from our phone number is ours" do
    assert {:ok, %MessageInfo{is_from_me?: true}} =
             MessageInfo.from_node(message("966501234567@s.whatsapp.net"), @pn, @lid)
  end

  @doc """
  The case that was silently false. The server addresses some of its own
  traffic — history sync among it — from the account's LID rather than its
  phone number.
  """
  test "and a message from our own LID is ours too" do
    assert {:ok, %MessageInfo{is_from_me?: true}} =
             MessageInfo.from_node(message("132680784040127@lid"), @pn, @lid)
  end

  test "somebody else is still somebody else" do
    assert {:ok, %MessageInfo{is_from_me?: false}} =
             MessageInfo.from_node(message("966509999999@s.whatsapp.net"), @pn, @lid)

    assert {:ok, %MessageInfo{is_from_me?: false}} =
             MessageInfo.from_node(message("999999999999999@lid"), @pn, @lid)
  end

  # A device with no LID stored — every clinic paired before LID addressing —
  # must behave exactly as it did before.
  test "and a device with no LID answers on the phone number alone" do
    assert {:ok, %MessageInfo{is_from_me?: true}} =
             MessageInfo.from_node(message("966501234567@s.whatsapp.net"), @pn, nil)

    assert {:ok, %MessageInfo{is_from_me?: false}} =
             MessageInfo.from_node(message("132680784040127@lid"), @pn, nil)
  end

  # `from_node/2` is what the tests and older callers use.
  test "the two-argument form still works" do
    assert {:ok, %MessageInfo{is_from_me?: true}} =
             MessageInfo.from_node(message("966501234567@s.whatsapp.net"), @pn)
  end
end
