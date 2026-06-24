defmodule Whatsmeow.MsgSecretTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.MsgSecret

  test "derive returns a 32-byte key" do
    {key, _aad} =
      MsgSecret.derive(
        :reaction,
        "1234@s.whatsapp.net",
        "MSG-1",
        "5678@s.whatsapp.net",
        :crypto.strong_rand_bytes(32)
      )

    assert byte_size(key) == 32
  end

  test "derive is deterministic for the same inputs" do
    secret = :crypto.strong_rand_bytes(32)
    args = [:poll_vote, "1@s.whatsapp.net", "MID", "2@s.whatsapp.net", secret]

    {k1, aad1} = apply(MsgSecret, :derive, args)
    {k2, aad2} = apply(MsgSecret, :derive, args)

    assert k1 == k2
    assert aad1 == aad2
  end

  test "different use cases produce different keys" do
    secret = :crypto.strong_rand_bytes(32)
    base = ["1@s.whatsapp.net", "MID", "2@s.whatsapp.net", secret]

    {kp, _} = apply(MsgSecret, :derive, [:poll_vote | base])
    {kr, _} = apply(MsgSecret, :derive, [:reaction | base])
    {kc, _} = apply(MsgSecret, :derive, [:comment | base])

    assert kp != kr
    assert kr != kc
    assert kp != kc
  end

  test "poll_vote and event_response emit AAD; others don't" do
    secret = :crypto.strong_rand_bytes(32)
    {_kp, aad_pv} = MsgSecret.derive(:poll_vote, "1@s", "MID", "2@s", secret)
    {_kr, aad_r} = MsgSecret.derive(:reaction, "1@s", "MID", "2@s", secret)
    {_ke, aad_er} = MsgSecret.derive(:event_response, "1@s", "MID", "2@s", secret)

    assert aad_pv == "MID" <> <<0>> <> "1@s"
    assert aad_er == "MID" <> <<0>> <> "1@s"
    assert is_nil(aad_r)
  end

  test "apply_bot_message_hkdf returns a 32-byte derivative" do
    secret = :crypto.strong_rand_bytes(32)
    derived = MsgSecret.apply_bot_message_hkdf(secret)
    assert byte_size(derived) == 32
    assert derived != secret
  end

  test "use_cases lists all named variants" do
    expected = [
      :poll_vote,
      :reaction,
      :comment,
      :report_token,
      :event_response,
      :event_edit,
      :message_edit,
      :poll_edit,
      :poll_add_option,
      :bot_message
    ]

    assert Enum.sort(MsgSecret.use_cases()) == Enum.sort(expected)
  end
end
