defmodule Whatsmeow.Push do
  @moduledoc """
  Push-notification token registration.

  WhatsApp pushes new-message alerts via FCM (Android), APNs (iOS),
  or Web Push (browsers). Once registered, the server batches deliveries
  to your device's native push service when the WhatsApp client isn't
  actively connected.

  ## When do you need this?

  Mostly you don't. If you're keeping a long-lived WebSocket open as a
  bot or server-side automation, push registration is wasted I/O. It
  matters when you're building a mobile or browser client whose
  WebSocket might be torn down between user sessions.

  Mirrors `whatsmeow-main/push.go`.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Session

  @server_jid "s.whatsapp.net"
  @namespace "urn:xmpp:whatsapp:push"
  @default_timeout 30_000

  defmodule FCM do
    @moduledoc "Firebase Cloud Messaging push token (Android)."
    @enforce_keys [:token]
    defstruct [:token]
    @type t :: %__MODULE__{token: String.t()}
  end

  defmodule APNs do
    @moduledoc """
    Apple Push Notification service token (iOS).

    `:msg_id_enc_key` must be 32 random bytes used to derive the per-message
    encryption key APNs payloads use; auto-generated if `nil`.
    """
    @enforce_keys [:token]
    defstruct [:token, :voip_token, :msg_id_enc_key]

    @type t :: %__MODULE__{
            token: String.t(),
            voip_token: String.t() | nil,
            msg_id_enc_key: binary() | nil
          }
  end

  defmodule Web do
    @moduledoc "W3C Push API subscription (browsers)."
    @enforce_keys [:endpoint, :auth, :p256dh]
    defstruct [:endpoint, :auth, :p256dh]

    @type t :: %__MODULE__{
            endpoint: String.t(),
            auth: binary(),
            p256dh: binary()
          }
  end

  # --- Public API ------------------------------------------------------------

  @doc """
  Register a push token with the server.

  Pass an `%FCM{}`, `%APNs{}`, or `%Web{}` config. Returns `:ok` on the IQ
  ack, or `{:error, reason}`.

  Mirrors `whatsmeow-main/push.go#RegisterForPushNotifications`.
  """
  @spec register(pid() | String.t(), FCM.t() | APNs.t() | Web.t(), keyword()) ::
          :ok | {:error, term()}
  def register(session, %_{} = config, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    case Session.send_iq(session, build_register_iq(config, opts), timeout) do
      {:ok, _resp} -> :ok
      {:error, _} = err -> err
    end
  end

  @doc """
  Build the `<iq xmlns="urn:xmpp:whatsapp:push" type="set">` payload.

  Public so it can be unit-tested without a live session.
  """
  @spec build_register_iq(FCM.t() | APNs.t() | Web.t(), keyword()) :: Node.t()
  def build_register_iq(%_{} = config, opts \\ []) do
    id = Keyword.get(opts, :id) || IQ.generate_id()
    attrs = config_attrs(config)

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => @server_jid,
        "type" => "set",
        "xmlns" => @namespace
      },
      [Node.new("config", attrs, nil)]
    )
  end

  @doc """
  Fetch the current server push-config blob via
  `<iq xmlns="urn:xmpp:whatsapp:push" type="get"><settings/></iq>`.
  """
  @spec get_server_config(pid() | String.t(), keyword()) ::
          {:ok, Node.t()} | {:error, term()}
  def get_server_config(session, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)
    id = Keyword.get(opts, :id) || IQ.generate_id()

    iq =
      Node.new(
        "iq",
        %{
          "id" => id,
          "to" => @server_jid,
          "type" => "get",
          "xmlns" => @namespace
        },
        [Node.new("settings", %{}, nil)]
      )

    Session.send_iq(session, iq, timeout)
  end

  # --- Attribute builders ----------------------------------------------------

  defp config_attrs(%FCM{token: token}) do
    %{
      "id" => token,
      "num_acc" => "1",
      "platform" => "gcm"
    }
  end

  defp config_attrs(%APNs{} = c) do
    key = c.msg_id_enc_key || :crypto.strong_rand_bytes(32)

    base = %{
      "id" => c.token,
      "platform" => "apple",
      "version" => "2",
      "reg_push" => "1",
      "preview" => "1",
      "pkey" => Base.url_encode64(key, padding: false),
      "background_location" => "1",
      "call" => "Opening.m4r",
      "default" => "note.m4r",
      "groups" => "note.m4r",
      "lg" => "en",
      "lc" => "US",
      "nse_call" => "0",
      "nse_ver" => "2",
      "nse_read" => "0",
      "voip_payload_type" => "2"
    }

    case c.voip_token do
      t when is_binary(t) and t != "" -> Map.put(base, "voip", t)
      _ -> base
    end
  end

  defp config_attrs(%Web{endpoint: endpoint, auth: auth, p256dh: p256dh}) do
    %{
      "platform" => "web",
      "endpoint" => endpoint,
      "auth" => Base.encode64(auth),
      "p256dh" => Base.encode64(p256dh)
    }
  end
end
