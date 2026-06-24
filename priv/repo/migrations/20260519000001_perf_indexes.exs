defmodule Whatsmeow.Repo.Migrations.PerfIndexes do
  @moduledoc """
  Performance indexes — secondary indexes on tables whose hot queries
  filter by a non-PK-prefix column.

    * `whatsmeow_app_state_mutation_macs` — patch-apply path looks up
      MACs by `(jid, name)` (the version column comes from the patch,
      not the query). Without this index the lookup degrades into a
      full scan over the partial PK.

    * `whatsmeow_contacts` — reverse-lookup queries that filter on
      `their_jid` alone (e.g. "who is this LID?") fall off the PK
      prefix `(our_jid, their_jid)` and full-scan.

    * `whatsmeow_pre_keys` — the steady-state pool fetch in
      `Whatsmeow.PreKeys.get_or_generate/2` filters by
      `(jid, uploaded=false)`; a partial covering index makes the
      pool lookup a fast index-only seek.

  All `create index` calls are `:if_not_exists`-safe via `IF NOT EXISTS`
  generation (Ecto adds it when `:concurrently` is off).
  """

  use Ecto.Migration

  def change do
    create_if_not_exists(
      index(:whatsmeow_app_state_mutation_macs, [:jid, :name],
        name: :whatsmeow_app_state_mutation_macs_jid_name_idx
      )
    )

    create_if_not_exists(
      index(:whatsmeow_contacts, [:their_jid], name: :whatsmeow_contacts_their_jid_idx)
    )

    create_if_not_exists(
      index(
        :whatsmeow_pre_keys,
        [:jid, :key_id],
        where: "uploaded = false",
        name: :whatsmeow_pre_keys_pool_idx
      )
    )
  end
end
