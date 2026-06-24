defmodule Whatsmeow.Repo.Migrations.AddClientIdToWhatsmeowDevice do
  @moduledoc """
  Adds a stable `client_id` column to `whatsmeow_device`.

  The existing primary key `jid` is rewritten by `<pair-success>` from the
  caller-supplied placeholder (e.g. `"user-42"`) to the real WhatsApp JID
  (e.g. `"12345@s.whatsapp.net"`). Reconnect flows that look the device up
  by the original caller key would therefore lose the row. `client_id` is
  the immutable host-application key; PubSub topics, the Sessions registry,
  and `find_or_new_device/1` use it instead of `jid`.
  """

  use Ecto.Migration

  def up do
    alter table(:whatsmeow_device) do
      add(:client_id, :text)
    end

    execute("UPDATE whatsmeow_device SET client_id = jid WHERE client_id IS NULL")

    create(unique_index(:whatsmeow_device, [:client_id]))
  end

  def down do
    drop(unique_index(:whatsmeow_device, [:client_id]))

    alter table(:whatsmeow_device) do
      remove(:client_id)
    end
  end
end
