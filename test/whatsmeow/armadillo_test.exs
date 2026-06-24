defmodule Whatsmeow.ArmadilloTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Armadillo
  alias Whatsmeow.Armadillo.Envelope

  test "marshal/2 wraps payload with version" do
    env = Armadillo.marshal("hello", :fb)
    assert %Envelope{payload: "hello", version: 1} = env
  end

  test "marshal/2 accepts a raw integer version" do
    env = Armadillo.marshal("x", 42)
    assert env.version == 42
  end

  test "unmarshal round-trip" do
    env = Armadillo.marshal("payload", :ig)
    assert {:ok, "payload"} = Armadillo.unmarshal(env, :ig)
  end

  test "unmarshal rejects mismatched version" do
    env = Armadillo.marshal("p", :fb)
    assert {:error, {:unsupported_version, 1, 5}} = Armadillo.unmarshal(env, :ig)
  end

  test "unmarshal flags missing payload" do
    assert {:error, :missing_payload} =
             Armadillo.unmarshal(%Envelope{payload: nil, version: 1}, :fb)
  end

  test "route/1 picks the right protocol family" do
    fb = Armadillo.marshal("fb", :fb)
    ig = Armadillo.marshal("ig", :ig)
    assert {:fb, "fb"} = Armadillo.route(fb)
    assert {:ig, "ig"} = Armadillo.route(ig)
  end

  test "route/1 rejects unknown versions" do
    env = %Envelope{payload: "x", version: 99}
    assert {:error, {:unsupported_version, 99, [:fb, :ig]}} = Armadillo.route(env)
  end
end
