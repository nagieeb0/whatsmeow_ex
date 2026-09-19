defmodule Whatsmeow.VersionRecoveryTest do
  @moduledoc """
  The auto-recovery that reported success for doing nothing.

  Measured in production on 19 September, four consecutive lines:

      client version {2, 3000, 1047935283}
      <failure> reason=:client_outdated attrs=%{"reason" => "405"}
      forcing WAVersion.refresh/1 (client-outdated auto-recovery)
      WAVersion refreshed to {2, 3000, 1047935283} after stream:error 500

  It "refreshed" to the version it already had, and blamed a `stream:error 500`
  when the trigger was a `<failure 405>`. So a working recovery and a no-op read
  identically — and the fact worth having was buried: WhatsApp calls this client
  outdated **and** the newest published version is the one already pinned. Those
  two together mean the rejection is not about the version at all, and no amount
  of refreshing will fix it.

  The connect recovers on the next attempt regardless, so this costs one wasted
  handshake per deploy rather than an outage. Which is precisely why it went on
  being invisible.
  """
  use ExUnit.Case, async: false

  alias Whatsmeow.WAVersion

  setup do
    on_exit(&WAVersion.clear_cache/0)
    :ok
  end

  test "the pinned version is what a refusal is compared against" do
    WAVersion.put_cached({2, 3000, 1_047_935_283})

    assert WAVersion.cached() == {2, 3000, 1_047_935_283}
  end

  test "and an untouched cache still answers, so the comparison is never nil" do
    WAVersion.clear_cache()

    assert {2, 3000, _revision} = WAVersion.cached()
  end

  describe "what the recovery is allowed to claim" do
    # Driven from source rather than by running the private task: the branch
    # that matters is the one comparing before and after, and pinning the call
    # sites is what stops the cause being hardcoded again.
    setup do: %{source: File.read!("lib/whatsmeow/session.ex")}

    @doc """
    Two triggers, two causes — and the line named only one, so every `405` was
    reported as a `500`. A log that names the wrong cause is worse than one that
    names none: it sends the reader to the wrong file.
    """
    test "each trigger names its own cause", %{source: source} do
      assert source =~ "<failure 405 client-outdated>"
      assert source =~ "<stream:error 500>"

      refute source =~ "after stream:error 500\"",
             "hardcoding the cause is how a 405 was reported as a 500 every time"
    end

    test "an unchanged version is reported as an error, not a refresh", %{source: source} do
      assert source =~ "{:ok, ^before}", "the no-op needs its own branch to be sayable at all"
      assert source =~ "SAME version"

      assert source =~ "Logger.error",
             "a contradiction WhatsApp is asserting about us is not a warning"
    end

    test "and a version that really moved says where it moved from", %{source: source} do
      assert source =~ "WAVersion moved"
      assert source =~ "(was #{"\#{inspect(before)}"})" or source =~ "was #"
    end
  end
end
