defmodule Whatsmeow.Store.Schemas.Device do
  @moduledoc """
  Persisted account / device record. The `jid` is the primary key; all
  per-account state hangs off this row via foreign keys.

  Mirrors `whatsmeow_device` from the upstream schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:jid, :string, []}
  schema "whatsmeow_device" do
    field(:client_id, :string)
    field(:lid, :string)
    field(:facebook_uuid, Ecto.UUID)

    field(:registration_id, :integer)

    field(:noise_key, :binary)
    field(:identity_key, :binary)

    field(:signed_pre_key, :binary)
    field(:signed_pre_key_id, :integer)
    field(:signed_pre_key_sig, :binary)

    field(:adv_key, :binary)
    field(:adv_details, :binary)
    field(:adv_account_sig, :binary)
    field(:adv_account_sig_key, :binary)
    field(:adv_device_sig, :binary)

    field(:platform, :string, default: "")
    field(:business_name, :string, default: "")
    field(:push_name, :string, default: "")

    field(:lid_migration_ts, :integer, default: 0)

    field(:persona, :map)
  end

  @required ~w(jid registration_id noise_key identity_key signed_pre_key signed_pre_key_id
               signed_pre_key_sig adv_key adv_details adv_account_sig adv_account_sig_key
               adv_device_sig)a
  @optional ~w(client_id lid facebook_uuid platform business_name push_name lid_migration_ts persona)a

  def changeset(device, attrs) do
    device
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> unique_constraint(:client_id)
    |> validate_byte_length(:noise_key, 32)
    |> validate_byte_length(:identity_key, 32)
    |> validate_byte_length(:signed_pre_key, 32)
    |> validate_byte_length(:signed_pre_key_sig, 64)
    |> validate_byte_length(:adv_account_sig, 64)
    |> validate_byte_length(:adv_account_sig_key, 32)
    |> validate_byte_length(:adv_device_sig, 64)
    |> validate_number(:registration_id, greater_than_or_equal_to: 0, less_than: 4_294_967_296)
    |> validate_number(:signed_pre_key_id,
      greater_than_or_equal_to: 0,
      less_than: 16_777_216
    )
  end

  defp validate_byte_length(changeset, field, expected) do
    validate_change(changeset, field, fn ^field, value ->
      if is_binary(value) and byte_size(value) == expected,
        do: [],
        else: [{field, "must be exactly #{expected} bytes (got #{inspect(value)})"}]
    end)
  end
end
