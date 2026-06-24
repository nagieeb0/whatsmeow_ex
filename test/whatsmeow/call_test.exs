defmodule Whatsmeow.CallTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Call
  alias Whatsmeow.Types.JID

  describe "build_reject/4" do
    test "produces canonical <call><reject> shape" do
      node =
        Call.build_reject("11111@s.whatsapp.net", "22222@s.whatsapp.net", "CALL-ID-123",
          msg_id: "FIXED-MSG"
        )

      assert node.tag == "call"
      assert node.attrs["id"] == "FIXED-MSG"
      assert %JID{user: "11111"} = node.attrs["from"]
      assert %JID{user: "22222"} = node.attrs["to"]

      [reject] = node.content
      assert reject.tag == "reject"
      assert reject.attrs["call-id"] == "CALL-ID-123"
      assert reject.attrs["count"] == "0"
      assert %JID{user: "22222"} = reject.attrs["call-creator"]
    end

    test "strips agent/device when given AD-JID" do
      {:ok, ad_jid} = JID.parse("11111.0:1@s.whatsapp.net")

      node = Call.build_reject(ad_jid, "22222@s.whatsapp.net", "CALL")

      assert node.attrs["from"].device == 0
      assert node.attrs["from"].agent == 0
    end

    test "auto-generates msg_id when not provided" do
      node = Call.build_reject("11111@s.whatsapp.net", "22222@s.whatsapp.net", "CALL")
      assert is_binary(node.attrs["id"])
      assert String.starts_with?(node.attrs["id"], "3EB0")
    end
  end
end
