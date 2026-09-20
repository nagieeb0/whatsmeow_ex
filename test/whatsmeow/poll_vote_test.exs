defmodule Whatsmeow.PollVoteTest do
  @moduledoc """
  A vote is only readable by the two people who derived the same key.

  The derivation takes both participants' JID **strings**, so a number and a LID
  for the same person produce different keys — and a mismatch is an
  authentication failure, not a wrong answer. Go carries a fallback for exactly
  this (`whatsmeow-main/msgsecret.go:113-121`) and calls it a hack; these tests
  pin it, because the same trap has already cost this codebase three guesses on
  reactions.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.MsgSecret
  alias Whatsmeow.Send

  @poll_id "3EB0POLL"
  @creator_pn "966511792082@s.whatsapp.net"
  @creator_lid "184142562087139@lid"
  @voter "201141465543@s.whatsapp.net"

  defp poll(options), do: Send.build_poll_creation("متى يناسبك؟", options, 1)

  defp vote_from(secret, creator, chosen) do
    plaintext =
      %WAWebProtobufsE2E.PollVoteMessage{selectedOptions: MsgSecret.hash_poll_options(chosen)}
      |> WAWebProtobufsE2E.PollVoteMessage.encode()
      |> IO.iodata_to_binary()

    {ct, iv} = MsgSecret.encrypt(:poll_vote, @voter, @poll_id, creator, secret, plaintext)

    %WAWebProtobufsE2E.PollUpdateMessage{
      pollCreationMessageKey: %WACommon.MessageKey{ID: @poll_id},
      vote: %WAWebProtobufsE2E.PollEncValue{encPayload: ct, encIV: iv}
    }
  end

  test "a vote decrypts to the hashes of the options tapped" do
    options = ~w(الأحد الاثنين الثلاثاء)
    secret = poll(options).messageContextInfo.messageSecret

    update = vote_from(secret, @creator_pn, ["الاثنين"])

    assert {:ok, [chosen]} = MsgSecret.decrypt_poll_vote(update, @voter, @creator_pn, secret)
    assert chosen == :crypto.hash(:sha256, "الاثنين")

    assert Enum.find_index(MsgSecret.hash_poll_options(options), &(&1 == chosen)) == 1
  end

  test "more than one option comes back in order" do
    secret = poll(~w(أ ب ج)).messageContextInfo.messageSecret
    update = vote_from(secret, @creator_pn, ~w(أ ج))

    assert {:ok, chosen} = MsgSecret.decrypt_poll_vote(update, @voter, @creator_pn, secret)
    assert chosen == MsgSecret.hash_poll_options(~w(أ ج))
  end

  # The whole reason `poll_senders` is a list.
  test "the wrong one of our two addresses does not decrypt" do
    secret = poll(~w(أ ب)).messageContextInfo.messageSecret
    update = vote_from(secret, @creator_lid, ["ب"])

    assert MsgSecret.decrypt_poll_vote(update, @voter, @creator_pn, secret) ==
             {:error, :aead_auth_failed}
  end

  test "so both are offered, and the one that derives wins" do
    secret = poll(~w(أ ب)).messageContextInfo.messageSecret
    update = vote_from(secret, @creator_lid, ["ب"])

    assert {:ok, [chosen]} =
             MsgSecret.decrypt_poll_vote(update, @voter, [@creator_pn, @creator_lid], secret)

    assert chosen == :crypto.hash(:sha256, "ب")
  end

  test "a voter who is not who the key was derived for gets nothing" do
    secret = poll(~w(أ ب)).messageContextInfo.messageSecret
    update = vote_from(secret, @creator_pn, ["أ"])

    assert MsgSecret.decrypt_poll_vote(update, "999@s.whatsapp.net", @creator_pn, secret) ==
             {:error, :aead_auth_failed}
  end

  test "anything that is not a poll vote says so instead of raising" do
    assert MsgSecret.decrypt_poll_vote(%WAWebProtobufsE2E.PollUpdateMessage{}, @voter, [], "k") ==
             {:error, :not_a_poll_vote}
  end
end
