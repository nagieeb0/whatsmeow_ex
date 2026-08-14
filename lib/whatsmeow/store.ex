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

  @doc """
  Persist a device, creating or updating as needed.

  Keyed by `client_id` when the device has one, `jid` otherwise. That matters
  because pairing *rewrites* the jid — a device starts life as `"user-42"` and
  becomes `"12345@s.whatsapp.net"` — so keying the write on jid would leave two
  rows and the paired credentials in whichever one the next boot didn't read.
  """
  @callback put_device(Schemas.Device.t()) :: :ok | {:error, term()}

  # --- Identity & sessions --------------------------------------------------
  @callback put_identity(device_id, jid, binary()) :: :ok | {:error, term()}
  @callback get_identity(device_id, jid) :: {:ok, binary()} | {:error, :not_found}

  @callback put_session(device_id, jid, binary()) :: :ok | {:error, term()}
  @callback get_session(device_id, jid) :: {:ok, binary()} | {:error, :not_found}

  # --- Pre-keys -------------------------------------------------------------
  @callback put_pre_key(device_id, integer(), binary(), boolean()) :: :ok
  @callback get_pre_key(device_id, integer()) :: {:ok, binary()} | {:error, :not_found}

  # --- Convenience facade ---------------------------------------------------
  @doc """
  Build a fresh (unpersisted) device struct.

  The key generation lives here rather than in an adapter because it is storage
  independent and subtle enough that a second copy would eventually drift:
  X25519 privates must come from `Curve25519.generate_keypair/0` so the scalar is
  RFC-7748 clamped, and `signed_pre_key_sig` must be an XEdDSA signature over
  `DjbType(5) || spk_pub` made with the identity key. Get either wrong and the
  server drops the pairing session with `<stream:error code="500">` right after
  the Noise handshake — with no hint as to why.

  Adapters call this and then persist the result.
  """
  @spec build_device(keyword()) :: Schemas.Device.t()
  def build_device(opts \\ []) do
    identity_key = Keyword.get_lazy(opts, :identity_key, &fresh_private/0)
    signed_pre_key = Keyword.get_lazy(opts, :signed_pre_key, &fresh_private/0)
    noise_key = Keyword.get_lazy(opts, :noise_key, &fresh_private/0)

    signed_pre_key_sig =
      Keyword.get_lazy(opts, :signed_pre_key_sig, fn ->
        spk_pub = Whatsmeow.Crypto.Curve25519.public_for(signed_pre_key)
        Whatsmeow.Crypto.XEdDSA.sign(identity_key, <<5, spk_pub::binary>>)
      end)

    jid =
      Keyword.get_lazy(opts, :jid, fn ->
        "device-" <> Base.encode16(:crypto.strong_rand_bytes(8), case: :lower)
      end)

    %Schemas.Device{
      jid: jid,
      client_id: Keyword.get(opts, :client_id, jid),
      registration_id: Keyword.get(opts, :registration_id, :rand.uniform(4_294_967_296) - 1),
      noise_key: noise_key,
      identity_key: identity_key,
      signed_pre_key: signed_pre_key,
      signed_pre_key_id: Keyword.get(opts, :signed_pre_key_id, 1),
      signed_pre_key_sig: signed_pre_key_sig,
      adv_key: Keyword.get(opts, :adv_key, :crypto.strong_rand_bytes(32)),
      adv_details: Keyword.get(opts, :adv_details, <<>>),
      adv_account_sig: Keyword.get(opts, :adv_account_sig, :crypto.strong_rand_bytes(64)),
      adv_account_sig_key: Keyword.get(opts, :adv_account_sig_key, :crypto.strong_rand_bytes(32)),
      adv_device_sig: Keyword.get(opts, :adv_device_sig, :crypto.strong_rand_bytes(64)),
      # Per-device fingerprint persona (UA/device-props). Caller passes a random
      # one so numbers don't all look like the same client; nil falls back to the
      # app-env/default persona at payload-build time.
      persona: Keyword.get(opts, :persona)
    }
  end

  defp fresh_private do
    {_pub, priv} = Whatsmeow.Crypto.Curve25519.generate_keypair()
    priv
  end

  @spec impl() :: module()
  def impl, do: Application.get_env(:whatsmeow_ex, :store, Whatsmeow.Store.Postgres)

  @spec new_device(keyword()) :: {:ok, Schemas.Device.t()} | {:error, term()}
  def new_device(opts \\ []), do: impl().new_device(opts)

  @spec get_device(device_id) :: {:ok, Schemas.Device.t()} | {:error, :not_found}
  def get_device(device_id), do: impl().get_device(device_id)

  @spec list_devices() :: [Schemas.Device.t()]
  def list_devices, do: impl().list_devices()

  @spec put_device(Schemas.Device.t()) :: :ok | {:error, term()}
  def put_device(device), do: impl().put_device(device)

  @spec delete_device(String.t()) :: :ok | {:error, term()}
  def delete_device(device_id), do: impl().delete_device(device_id)

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
