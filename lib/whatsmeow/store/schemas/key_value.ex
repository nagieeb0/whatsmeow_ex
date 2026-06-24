defmodule Whatsmeow.Store.Schemas.IdentityKey do
  @moduledoc "Per-peer 32-byte identity key (Signal protocol)."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_identity_keys" do
    field(:our_jid, :string, primary_key: true)
    field(:their_id, :string, primary_key: true)
    field(:identity, :binary)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :their_id, :identity])
    |> validate_required([:our_jid, :their_id, :identity])
    |> validate_change(:identity, fn :identity, v ->
      if byte_size(v) == 32, do: [], else: [identity: "must be 32 bytes"]
    end)
  end
end

defmodule Whatsmeow.Store.Schemas.PreKey do
  @moduledoc "A Signal one-time pre-key, with an upload flag."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_pre_keys" do
    field(:jid, :string, primary_key: true)
    field(:key_id, :integer, primary_key: true)
    field(:key, :binary)
    field(:uploaded, :boolean)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:jid, :key_id, :key, :uploaded])
    |> validate_required([:jid, :key_id, :key, :uploaded])
  end
end

defmodule Whatsmeow.Store.Schemas.Session do
  @moduledoc "Serialised Signal session state for a peer."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_sessions" do
    field(:our_jid, :string, primary_key: true)
    field(:their_id, :string, primary_key: true)
    field(:session, :binary)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :their_id, :session])
    |> validate_required([:our_jid, :their_id])
  end
end

defmodule Whatsmeow.Store.Schemas.SenderKey do
  @moduledoc "Group sender key — keyed by (our_jid, chat_id, sender_id)."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_sender_keys" do
    field(:our_jid, :string, primary_key: true)
    field(:chat_id, :string, primary_key: true)
    field(:sender_id, :string, primary_key: true)
    field(:sender_key, :binary)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :chat_id, :sender_id, :sender_key])
    |> validate_required([:our_jid, :chat_id, :sender_id, :sender_key])
  end
end

defmodule Whatsmeow.Store.Schemas.AppStateSyncKey do
  @moduledoc "App-state sync encryption keys (keyed by 6-byte key_id)."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_app_state_sync_keys" do
    field(:jid, :string, primary_key: true)
    field(:key_id, :binary, primary_key: true)
    field(:key_data, :binary)
    field(:timestamp, :integer)
    field(:fingerprint, :binary)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:jid, :key_id, :key_data, :timestamp, :fingerprint])
    |> validate_required([:jid, :key_id, :key_data, :timestamp, :fingerprint])
  end
end

defmodule Whatsmeow.Store.Schemas.AppStateVersion do
  @moduledoc "Per-collection app-state version + 128-byte LTHash fingerprint."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_app_state_version" do
    field(:jid, :string, primary_key: true)
    field(:name, :string, primary_key: true)
    field(:version, :integer)
    field(:hash, :binary)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:jid, :name, :version, :hash])
    |> validate_required([:jid, :name, :version, :hash])
    |> validate_change(:hash, fn :hash, v ->
      if byte_size(v) == 128, do: [], else: [hash: "must be 128 bytes"]
    end)
  end
end

defmodule Whatsmeow.Store.Schemas.AppStateMutationMAC do
  @moduledoc "App-state mutation MAC index (for tamper detection on resync)."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_app_state_mutation_macs" do
    field(:jid, :string, primary_key: true)
    field(:name, :string, primary_key: true)
    field(:version, :integer, primary_key: true)
    field(:index_mac, :binary, primary_key: true)
    field(:value_mac, :binary)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:jid, :name, :version, :index_mac, :value_mac])
    |> validate_required([:jid, :name, :version, :index_mac, :value_mac])
  end
end

defmodule Whatsmeow.Store.Schemas.Contact do
  @moduledoc "Cached contact info (names, push name, business name, phone)."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_contacts" do
    field(:our_jid, :string, primary_key: true)
    field(:their_jid, :string, primary_key: true)
    field(:first_name, :string)
    field(:full_name, :string)
    field(:push_name, :string)
    field(:business_name, :string)
    field(:redacted_phone, :string)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [
      :our_jid,
      :their_jid,
      :first_name,
      :full_name,
      :push_name,
      :business_name,
      :redacted_phone
    ])
    |> validate_required([:our_jid, :their_jid])
  end
end

defmodule Whatsmeow.Store.Schemas.ChatSettings do
  @moduledoc "Per-chat mute/pin/archive state."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_chat_settings" do
    field(:our_jid, :string, primary_key: true)
    field(:chat_jid, :string, primary_key: true)
    field(:muted_until, :integer, default: 0)
    field(:pinned, :boolean, default: false)
    field(:archived, :boolean, default: false)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :chat_jid, :muted_until, :pinned, :archived])
    |> validate_required([:our_jid, :chat_jid])
  end
end

defmodule Whatsmeow.Store.Schemas.MessageSecret do
  @moduledoc "Per-message decryption secret (used for reactions, edits, polls)."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_message_secrets" do
    field(:our_jid, :string, primary_key: true)
    field(:chat_jid, :string, primary_key: true)
    field(:sender_jid, :string, primary_key: true)
    field(:message_id, :string, primary_key: true)
    field(:key, :binary)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :chat_jid, :sender_jid, :message_id, :key])
    |> validate_required([:our_jid, :chat_jid, :sender_jid, :message_id, :key])
  end
end

defmodule Whatsmeow.Store.Schemas.PrivacyToken do
  @moduledoc "Privacy verification tokens per peer."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_privacy_tokens" do
    field(:our_jid, :string, primary_key: true)
    field(:their_jid, :string, primary_key: true)
    field(:token, :binary)
    field(:timestamp, :integer)
    field(:sender_timestamp, :integer)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :their_jid, :token, :timestamp, :sender_timestamp])
    |> validate_required([:our_jid, :their_jid, :token, :timestamp])
  end
end

defmodule Whatsmeow.Store.Schemas.NCTSalt do
  @moduledoc "Per-account notification-cipher-text salt."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_nct_salt" do
    field(:our_jid, :string, primary_key: true)
    field(:salt, :binary)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :salt])
    |> validate_required([:our_jid, :salt])
  end
end

defmodule Whatsmeow.Store.Schemas.LIDMap do
  @moduledoc "LID ↔ phone-number mapping (linked devices)."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_lid_map" do
    field(:lid, :string, primary_key: true)
    field(:pn, :string)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:lid, :pn])
    |> validate_required([:lid, :pn])
    |> unique_constraint(:pn)
  end
end

defmodule Whatsmeow.Store.Schemas.EventBuffer do
  @moduledoc "Transient inbound-event buffer keyed by ciphertext hash."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_event_buffer" do
    field(:our_jid, :string, primary_key: true)
    field(:ciphertext_hash, :binary, primary_key: true)
    field(:plaintext, :binary)
    field(:server_timestamp, :integer)
    field(:insert_timestamp, :integer)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :ciphertext_hash, :plaintext, :server_timestamp, :insert_timestamp])
    |> validate_required([:our_jid, :ciphertext_hash, :server_timestamp, :insert_timestamp])
  end
end

defmodule Whatsmeow.Store.Schemas.RetryBuffer do
  @moduledoc "Outbound retry queue (durable across reconnects)."
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "whatsmeow_retry_buffer" do
    field(:our_jid, :string, primary_key: true)
    field(:chat_jid, :string, primary_key: true)
    field(:message_id, :string, primary_key: true)
    field(:format, :string)
    field(:plaintext, :binary)
    field(:timestamp, :integer)
  end

  def changeset(rec, attrs) do
    rec
    |> cast(attrs, [:our_jid, :chat_jid, :message_id, :format, :plaintext, :timestamp])
    |> validate_required([:our_jid, :chat_jid, :message_id, :format, :plaintext, :timestamp])
  end
end
