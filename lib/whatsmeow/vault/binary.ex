defmodule Whatsmeow.Vault.Binary do
  @moduledoc """
  Ecto type that transparently encrypts a `:binary` column at rest via
  `Whatsmeow.Vault`. `cast/1` is the identity (the in-memory value stays the raw
  key bytes, so byte-length validations still see the real key), `dump/1`
  encrypts on the way to Postgres, and `load/1` decrypts on the way back.

  Stored as `bytea`, so it is a drop-in replacement for `field _, :binary` with
  no migration. With no vault key configured it is a passthrough.
  """
  use Ecto.Type

  @impl true
  def type, do: :binary

  @impl true
  def cast(value) when is_binary(value), do: {:ok, value}
  def cast(nil), do: {:ok, nil}
  def cast(_), do: :error

  @impl true
  def dump(value) when is_binary(value), do: {:ok, Whatsmeow.Vault.encrypt(value)}
  def dump(nil), do: {:ok, nil}
  def dump(_), do: :error

  @impl true
  def load(value) when is_binary(value), do: {:ok, Whatsmeow.Vault.decrypt(value)}
  def load(nil), do: {:ok, nil}
end
