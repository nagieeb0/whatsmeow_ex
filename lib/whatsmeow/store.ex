defmodule Whatsmeow.Store do
  @moduledoc """
  Persistence facade for the library.

  Defines a behaviour for store implementations so consumers can swap the
  default Postgres-backed `Whatsmeow.Store.Postgres` for ETS-backed mocks
  or a custom adapter.

  Mirrors the surface of `whatsmeow-main/store/store.go`.
  """

  alias Whatsmeow.Store.Schemas

  @type device_id :: String.t()
  @type jid :: String.t()

  # --- Device management ---------------------------------------------------
  @callback new_device(keyword()) :: {:ok, Schemas.Device.t()} | {:error, term()}
  @callback get_device(device_id) :: {:ok, Schemas.Device.t()} | {:error, :not_found}
  @callback get_device_by_client_id(String.t()) ::
              {:ok, Schemas.Device.t()} | {:error, :not_found}
  @callback list_devices() :: [Schemas.Device.t()]
  @callback delete_device(device_id) :: :ok | {:error, term()}

  # --- Identity & sessions --------------------------------------------------
  @callback put_identity(device_id, jid, binary()) :: :ok | {:error, term()}
  @callback get_identity(device_id, jid) :: {:ok, binary()} | {:error, :not_found}

  @callback put_session(device_id, jid, binary()) :: :ok | {:error, term()}
  @callback get_session(device_id, jid) :: {:ok, binary()} | {:error, :not_found}

  # --- Pre-keys -------------------------------------------------------------
  @callback put_pre_key(device_id, integer(), binary(), boolean()) :: :ok
  @callback get_pre_key(device_id, integer()) :: {:ok, binary()} | {:error, :not_found}

  # --- Convenience facade ---------------------------------------------------
  @spec impl() :: module()
  def impl, do: Application.get_env(:whatsmeow_ex, :store, Whatsmeow.Store.Postgres)

  @spec new_device(keyword()) :: {:ok, Schemas.Device.t()} | {:error, term()}
  def new_device(opts \\ []), do: impl().new_device(opts)

  @spec get_device(device_id) :: {:ok, Schemas.Device.t()} | {:error, :not_found}
  def get_device(device_id), do: impl().get_device(device_id)

  @spec list_devices() :: [Schemas.Device.t()]
  def list_devices, do: impl().list_devices()

  @doc """
  Look up a device by `client_id` (a host-application-supplied identifier).

  `client_id` is the stable, host-owned key for a paired account. It is
  written once at creation time and **never** changes — unlike `jid`, which
  the server rewrites during pair-success. Use `client_id` for PubSub
  subscriptions, session registry lookups, and reconnect flows.

  Returns the existing record if found, otherwise creates a fresh one with
  `client_id` set and `jid` defaulted to the same value (it'll be replaced
  by the real WhatsApp JID after `<pair-success>`).
  """
  @spec find_or_new_device(keyword()) :: {:ok, Schemas.Device.t()} | {:error, term()}
  def find_or_new_device(opts) do
    case Keyword.fetch(opts, :client_id) do
      {:ok, client_id} ->
        case get_device_by_client_id(client_id) do
          {:ok, device} ->
            {:ok, device}

          {:error, :not_found} ->
            opts
            |> Keyword.put_new(:jid, client_id)
            |> Keyword.put(:client_id, client_id)
            |> new_device()
        end

      :error ->
        new_device(opts)
    end
  end

  @doc "Look up a device by its host-supplied `client_id`."
  @spec get_device_by_client_id(String.t()) ::
          {:ok, Schemas.Device.t()} | {:error, :not_found}
  def get_device_by_client_id(client_id) when is_binary(client_id),
    do: impl().get_device_by_client_id(client_id)
end
