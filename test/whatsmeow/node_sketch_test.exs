defmodule Whatsmeow.NodeSketchTest do
  @moduledoc """
  What the server actually said, in a form that can leave the machine.

  Eight hypotheses about the post-deploy offline-sync stall died against a
  measurement, and each measurement cost a deploy — because the only reading
  available was a tally. `%{"iq" => 21}` says twenty-one IQs were answered and
  cannot say which, so "the server ignored our `digest`" and "the server
  answered it and the fault is elsewhere" produced identical output.

  The summary is served by an authenticated health endpoint, so the tests that
  matter most here are the redaction ones.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node

  doctest Whatsmeow.Binary.Node, import: true

  defp n(tag, attrs \\ %{}, content \\ nil), do: %Node{tag: tag, attrs: attrs, content: content}

  test "an iq names its type and the child's namespace" do
    sketch =
      n("iq", %{"type" => "result", "id" => "17"}, [n("list", %{"xmlns" => "blocklist"})])
      |> Node.sketch()

    assert sketch == "iq[type=result](list[xmlns=blocklist])"
  end

  test "a failure carries the reason, which is the whole point of reading one" do
    assert Node.sketch(n("failure", %{"reason" => "401", "location" => "frc"})) ==
             "failure[reason=401]"
  end

  describe "redaction" do
    # The endpoint is authenticated, not private. A stanza carries a patient's
    # number in `from`, `to`, `participant` and `jid`, and their WhatsApp
    # display name in `notify`.
    test "a jid never appears, under any key" do
      sketch =
        n("message", %{
          "from" => "966501234567@s.whatsapp.net",
          "participant" => "966509999999@lid",
          "notify" => "محمد عبد العزيز",
          "type" => "text"
        })
        |> Node.sketch()

      assert sketch == "message[type=text]"
      refute sketch =~ "966"
      refute sketch =~ "محمد"
    end

    test "and neither does a message body, at any depth" do
      sketch =
        n("message", %{"type" => "text"}, [
          n("enc", %{"type" => "msg"}, "عايز أحجز موعد بكرة الساعة ٥")
        ])
        |> Node.sketch()

      refute sketch =~ "أحجز"
      assert sketch =~ "enc[type=msg]"
    end

    # The allowlist is over keys, so a stanza that starts carrying a number
    # under an allowlisted key is still caught — a denylist would be one new
    # attribute away from publishing a phone number.
    test "a bare number under an allowed key is still masked" do
      assert Node.sketch(n("receipt", %{"type" => "966501234567"})) == "receipt[type=<num>]"
    end

    test "a JID struct is masked the same as its string form" do
      jid = %Whatsmeow.Types.JID{user: "966501234567", server: "s.whatsapp.net"}
      assert Node.sketch(n("iq", %{"type" => jid})) == "iq[type=<jid>]"
    end
  end

  test "children are capped, and the cap says how many it hid" do
    kids = for i <- 1..7, do: n("item", %{"count" => i})
    sketch = Node.sketch(n("ib", %{}, kids))

    assert sketch == "ib(item[count=1],item[count=2],item[count=3],+4)"
  end

  test "a bare node is just its tag" do
    assert Node.sketch(n("success")) == "success"
  end
end
