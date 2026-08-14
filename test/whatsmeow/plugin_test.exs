defmodule Whatsmeow.PluginTest do
  use ExUnit.Case, async: false

  alias Whatsmeow.{Content, Plugin, Testing}
  alias Whatsmeow.Types.Events

  setup do
    Plugin.clear(:all)
    on_exit(fn -> Plugin.clear(:all) end)
    {:ok, session} = Testing.start_offline()
    %{session: session}
  end

  describe "registration" do
    test "steps run in registration order" do
      Plugin.attach(:send, :a, fn ctx -> {:cont, Map.update(ctx, :trace, ["a"], &(&1 ++ ["a"]))} end)

      Plugin.attach(:send, :b, fn ctx -> {:cont, Map.update(ctx, :trace, ["b"], &(&1 ++ ["b"]))} end)

      assert Plugin.list(:send) == [:a, :b]
      assert {:ok, %{trace: ["a", "b"]}} = Plugin.run(:send, %{})
    end

    test "re-registering a name replaces in place rather than duplicating" do
      Plugin.attach(:send, :a, fn ctx -> {:cont, Map.put(ctx, :v, 1)} end)
      Plugin.attach(:send, :b, fn ctx -> {:cont, ctx} end)
      Plugin.attach(:send, :a, fn ctx -> {:cont, Map.put(ctx, :v, 2)} end)

      assert Plugin.list(:send) == [:a, :b]
      assert {:ok, %{v: 2}} = Plugin.run(:send, %{})
    end

    test "detach removes one step, clear removes all" do
      Plugin.attach(:send, :a, fn ctx -> {:cont, ctx} end)
      Plugin.attach(:send, :b, fn ctx -> {:cont, ctx} end)

      Plugin.detach(:send, :a)
      assert Plugin.list(:send) == [:b]

      Plugin.clear(:send)
      assert Plugin.list(:send) == []
    end

    test "the two stages are independent" do
      Plugin.attach(:send, :s, fn ctx -> {:cont, ctx} end)
      assert Plugin.list(:recv) == []
    end
  end

  describe "halting" do
    test "a halt stops the pipeline and later steps never run" do
      Plugin.attach(:send, :stop, fn _ -> {:halt, :nope} end)
      Plugin.attach(:send, :never, fn _ -> raise "must not run" end)

      assert {:halt, :nope} = Plugin.run(:send, %{})
    end

    test "a raising step fails open rather than dropping the message" do
      Plugin.attach(:send, :boom, fn _ -> raise "kaboom" end)
      Plugin.attach(:send, :after, fn ctx -> {:cont, Map.put(ctx, :reached, true)} end)

      assert {:ok, %{reached: true}} = Plugin.run(:send, %{})
    end

    test "a step returning garbage is ignored, not obeyed" do
      Plugin.attach(:send, :weird, fn _ -> :whatever end)
      assert {:ok, %{a: 1}} = Plugin.run(:send, %{a: 1})
    end
  end

  describe "send pipeline, end to end" do
    test "a step can rewrite the outgoing message", %{session: session} do
      Plugin.attach(:send, :shout, fn ctx ->
        {:cont,
         %{ctx | message: %{ctx.message | conversation: String.upcase(ctx.message.conversation)}}}
      end)

      {:ok, _id} = Whatsmeow.send_text(session, "15551234567@s.whatsapp.net", "hello")

      assert [%{message: %{conversation: "HELLO"}}] = Testing.sent(session)
    end

    test "a blocklist step stops the send and tells the caller why", %{session: session} do
      Plugin.attach(:send, :blocklist, fn ctx ->
        if ctx.to.user == "15559999999", do: {:halt, :blocked}, else: {:cont, ctx}
      end)

      assert {:error, {:halted, :blocked}} =
               Whatsmeow.send_text(session, "15559999999@s.whatsapp.net", "hi")

      assert Testing.sent(session) == []

      assert {:ok, _} = Whatsmeow.send_text(session, "15551234567@s.whatsapp.net", "hi")
      assert length(Testing.sent(session)) == 1
    end

    test "the ctx carries the recipient and the device", %{session: session} do
      test_pid = self()

      Plugin.attach(:send, :spy, fn ctx ->
        send(test_pid, {:ctx, ctx})
        {:cont, ctx}
      end)

      {:ok, _} = Whatsmeow.send_message(session, "15551234567@s.whatsapp.net", Content.text("x"))

      assert_receive {:ctx, ctx}
      assert ctx.to.user == "15551234567"
      assert is_binary(ctx.device_id)
      assert %WAWebProtobufsE2E.Message{} = ctx.message
    end
  end

  describe "recv pipeline, end to end" do
    test "a dropped message never reaches a subscriber", %{session: session} do
      :ok = Testing.subscribe(session)

      Plugin.attach(:recv, :drop_spam, fn ctx ->
        if ctx.message.body == "spam", do: {:halt, :spam}, else: {:cont, ctx}
      end)

      Testing.deliver_text(session, from: "15551234567@s.whatsapp.net", text: "spam")
      refute_receive {:whatsmeow, %Events.Message{}}, 100

      Testing.deliver_text(session, from: "15551234567@s.whatsapp.net", text: "real")
      assert_receive {:whatsmeow, %Events.Message{message: %{body: "real"}}}
    end
  end
end
