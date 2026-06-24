defmodule WhatsmeowExTest do
  use ExUnit.Case, async: true

  test "version is a non-empty string" do
    assert is_binary(WhatsmeowEx.version())
    assert WhatsmeowEx.version() =~ ~r/^\d+\.\d+\.\d+/
  end
end
