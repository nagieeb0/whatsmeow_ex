defmodule Whatsmeow.Repo.Migrations.CreateWhatsmeowSchema do
  @moduledoc """
  Initial schema for whatsmeow_ex on Postgres. Mirrors
  `whatsmeow-main/store/sqlstore/upgrades/00-latest-schema.sql` (v0 → v14).

  Includes all 17 tables: devices, identity keys, pre-keys, sessions,
  sender keys, app-state sync keys / versions / mutation MACs, contacts,
  chat settings, message secrets, privacy tokens, NCT salt, LID map,
  event buffer, retry buffer.
  """

  use Ecto.Migration

  def change do
    create table(:whatsmeow_device, primary_key: false) do
      add(:jid, :text, primary_key: true)
      add(:lid, :text)
      add(:facebook_uuid, :uuid)

      add(:registration_id, :bigint, null: false)

      add(:noise_key, :binary, null: false)
      add(:identity_key, :binary, null: false)

      add(:signed_pre_key, :binary, null: false)
      add(:signed_pre_key_id, :integer, null: false)
      add(:signed_pre_key_sig, :binary, null: false)

      add(:adv_key, :binary, null: false)
      add(:adv_details, :binary, null: false)
      add(:adv_account_sig, :binary, null: false)
      add(:adv_account_sig_key, :binary, null: false)
      add(:adv_device_sig, :binary, null: false)

      add(:platform, :text, null: false, default: "")
      add(:business_name, :text, null: false, default: "")
      add(:push_name, :text, null: false, default: "")

      add(:lid_migration_ts, :bigint, null: false, default: 0)
    end

    create table(:whatsmeow_identity_keys, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:their_id, :text, primary_key: true)
      add(:identity, :binary, null: false)
    end

    create table(:whatsmeow_pre_keys, primary_key: false) do
      add(
        :jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:key_id, :integer, primary_key: true)
      add(:key, :binary, null: false)
      add(:uploaded, :boolean, null: false)
    end

    create table(:whatsmeow_sessions, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:their_id, :text, primary_key: true)
      add(:session, :binary)
    end

    create table(:whatsmeow_sender_keys, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:chat_id, :text, primary_key: true)
      add(:sender_id, :text, primary_key: true)
      add(:sender_key, :binary, null: false)
    end

    create table(:whatsmeow_app_state_sync_keys, primary_key: false) do
      add(
        :jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:key_id, :binary, primary_key: true)
      add(:key_data, :binary, null: false)
      add(:timestamp, :bigint, null: false)
      add(:fingerprint, :binary, null: false)
    end

    create table(:whatsmeow_app_state_version, primary_key: false) do
      add(
        :jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:name, :text, primary_key: true)
      add(:version, :bigint, null: false)
      add(:hash, :binary, null: false)
    end

    create table(:whatsmeow_app_state_mutation_macs, primary_key: false) do
      add(:jid, :text, primary_key: true)
      add(:name, :text, primary_key: true)
      add(:version, :bigint, primary_key: true)
      add(:index_mac, :binary, primary_key: true)
      add(:value_mac, :binary, null: false)
    end

    create table(:whatsmeow_contacts, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:their_jid, :text, primary_key: true)
      add(:first_name, :text)
      add(:full_name, :text)
      add(:push_name, :text)
      add(:business_name, :text)
      add(:redacted_phone, :text)
    end

    create table(:whatsmeow_chat_settings, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:chat_jid, :text, primary_key: true)
      add(:muted_until, :bigint, null: false, default: 0)
      add(:pinned, :boolean, null: false, default: false)
      add(:archived, :boolean, null: false, default: false)
    end

    create table(:whatsmeow_message_secrets, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:chat_jid, :text, primary_key: true)
      add(:sender_jid, :text, primary_key: true)
      add(:message_id, :text, primary_key: true)
      add(:key, :binary, null: false)
    end

    create table(:whatsmeow_privacy_tokens, primary_key: false) do
      add(:our_jid, :text, primary_key: true)
      add(:their_jid, :text, primary_key: true)
      add(:token, :binary, null: false)
      add(:timestamp, :bigint, null: false)
      add(:sender_timestamp, :bigint)
    end

    create(
      index(:whatsmeow_privacy_tokens, [:our_jid, :timestamp],
        name: :idx_whatsmeow_privacy_tokens_our_jid_timestamp
      )
    )

    create table(:whatsmeow_nct_salt, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true)

      add(:salt, :binary, null: false)
    end

    create table(:whatsmeow_lid_map, primary_key: false) do
      add(:lid, :text, primary_key: true)
      add(:pn, :text, null: false)
    end

    create(unique_index(:whatsmeow_lid_map, [:pn]))

    create table(:whatsmeow_event_buffer, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true, null: false)

      add(:ciphertext_hash, :binary, primary_key: true, null: false)
      add(:plaintext, :binary)
      add(:server_timestamp, :bigint, null: false)
      add(:insert_timestamp, :bigint, null: false)
    end

    create table(:whatsmeow_retry_buffer, primary_key: false) do
      add(
        :our_jid,
        references(:whatsmeow_device,
          column: :jid,
          type: :text,
          on_delete: :delete_all,
          on_update: :update_all
        ), primary_key: true, null: false)

      add(:chat_jid, :text, primary_key: true, null: false)
      add(:message_id, :text, primary_key: true, null: false)
      add(:format, :text, null: false)
      add(:plaintext, :binary, null: false)
      add(:timestamp, :bigint, null: false)
    end

    create(
      index(:whatsmeow_retry_buffer, [:our_jid, :timestamp],
        name: :whatsmeow_retry_buffer_timestamp_idx
      )
    )
  end
end
