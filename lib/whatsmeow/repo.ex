defmodule Whatsmeow.Repo do
  @moduledoc """
  Ecto Postgres repository for the library's durable state — devices,
  sessions, prekeys, identity keys, sender keys, app state, contacts.

  See `priv/repo/migrations/` for schema and `Whatsmeow.Store.Schemas.*` for
  resource definitions.
  """

  use Ecto.Repo,
    otp_app: :whatsmeow_ex,
    adapter: Ecto.Adapters.Postgres
end
