defmodule Whatsmeow.Repo.Migrations.AddPersonaToWhatsmeowDevice do
  use Ecto.Migration

  def change do
    alter table(:whatsmeow_device) do
      add(:persona, :map)
    end
  end
end
