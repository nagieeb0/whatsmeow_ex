defmodule Whatsmeow.ClientPayload do
  @moduledoc """
  Builds the `WAWebProtobufsWa6.ClientPayload` sent inside the
  Noise XX `ClientFinish` frame.

  There are two shapes:

  * **Registration payload** — sent on first connect for an unpaired device
    (no JID yet). Carries the registration ID, identity public key, signed
    pre-key, and device props (`DeviceProps` proto).
  * **Login payload** — sent on every reconnect for an already-paired device.
    Carries the user/device JID for re-auth.

  Ports `whatsmeow-main/store/clientpayload.go`.
  """

  alias Whatsmeow.ClientPayload.Persona
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.WAVersion

  alias WAWebProtobufsWa6.ClientPayload
  alias WAWebProtobufsWa6.ClientPayload.UserAgent
  alias WAWebProtobufsWa6.ClientPayload.UserAgent.AppVersion
  alias WAWebProtobufsWa6.ClientPayload.WebInfo
  alias WAWebProtobufsWa6.ClientPayload.DevicePairingRegistrationData
  alias WACompanionReg.DeviceProps

  @doc """
  WA web client version as a 3-tuple. Reads from `Whatsmeow.WAVersion`'s
  `:persistent_term` cache so refreshes propagate to every subsequent
  registration payload without restarting sessions.

  Falls back to `Whatsmeow.WAVersion.default_version/0` if the cache is
  empty (e.g. test environment that never called `WAVersion.refresh/1`).
  """
  @spec wa_version() :: {non_neg_integer(), non_neg_integer(), non_neg_integer()}
  def wa_version, do: WAVersion.cached()

  @doc """
  Md5 hash of the dot-separated version string — sent as `build_hash` inside
  `DevicePairingRegistrationData` during the registration payload.
  """
  @spec wa_version_hash() :: <<_::128>>
  def wa_version_hash do
    {a, b, c} = wa_version()
    :crypto.hash(:md5, "#{a}.#{b}.#{c}")
  end

  @doc """
  Build the appropriate `ClientPayload` for `device`. Picks login vs
  registration based on whether the device has a real WA JID assigned by
  the server (i.e. contains an `@` and the user part is numeric).

  Mirrors Go's `if cli.Store.ID == nil { registration } else { login }`.
  """
  @spec build(Device.t()) :: ClientPayload.t()
  def build(%Device{jid: jid} = device) do
    if paired?(jid) do
      login_payload(device)
    else
      registration_payload(device)
    end
  end

  @doc "Resolve the persona for `device` (persisted → app-env → built-in default)."
  @spec persona_for(Device.t() | map() | nil) :: Persona.t()
  def persona_for(device), do: Persona.for_device(device)

  # A paired device has a real WA JID like "1234567890:1@s.whatsapp.net" or
  # "1234567890@s.whatsapp.net". Anything without an "@" (placeholder JIDs
  # like "smoke-…", "device-…", or "") is unpaired and must use the
  # registration payload.
  defp paired?(jid) when is_binary(jid) do
    case String.split(jid, "@", parts: 2) do
      [user_part, server] when server != "" ->
        user_part
        |> String.split(":", parts: 2)
        |> hd()
        |> numeric?()

      _ ->
        false
    end
  end

  defp paired?(_), do: false

  defp numeric?(<<>>), do: false
  defp numeric?(s) when is_binary(s), do: String.match?(s, ~r/^\d+$/)

  @doc "Build a registration payload (first connect for an unpaired device)."
  @spec registration_payload(Device.t()) :: ClientPayload.t()
  def registration_payload(%Device{} = device) do
    persona = persona_for(device)

    %ClientPayload{
      userAgent: base_user_agent(persona),
      webInfo: %WebInfo{webSubPlatform: :WEB_BROWSER},
      connectType: :WIFI_UNKNOWN,
      connectReason: :USER_ACTIVATED,
      passive: false,
      pull: false,
      devicePairingData: %DevicePairingRegistrationData{
        eRegid: <<device.registration_id::big-unsigned-32>>,
        eKeytype: <<5>>,
        eIdent: identity_pub(device),
        eSkeyID: <<device.signed_pre_key_id::big-unsigned-24>>,
        eSkeyVal: signed_pre_key_pub(device),
        eSkeySig: device.signed_pre_key_sig,
        buildHash: wa_version_hash(),
        deviceProps: DeviceProps.encode(default_device_props(persona))
      }
    }
  end

  @doc "Build a login payload (reconnect for an already-paired device)."
  @spec login_payload(Device.t()) :: ClientPayload.t()
  def login_payload(%Device{} = device) do
    {user_int, device_id} = parse_jid_user_device(device.jid)

    %ClientPayload{
      userAgent: base_user_agent(persona_for(device)),
      webInfo: %WebInfo{webSubPlatform: :WEB_BROWSER},
      connectType: :WIFI_UNKNOWN,
      connectReason: :USER_ACTIVATED,
      username: user_int,
      device: device_id,
      passive: true,
      pull: true,
      lidDbMigrated: true,
      lc: 1
    }
  end

  @doc "Build the `UserAgent` for `persona`."
  @spec base_user_agent(Persona.t()) :: UserAgent.t()
  def base_user_agent(persona \\ Persona.configured()) do
    {p1, p2, p3} = wa_version()
    os_version = Persona.os_version_string(persona)

    %UserAgent{
      platform: :WEB,
      releaseChannel: :RELEASE,
      appVersion: %AppVersion{primary: p1, secondary: p2, tertiary: p3},
      mcc: persona.mcc,
      mnc: persona.mnc,
      osVersion: os_version,
      manufacturer: persona.manufacturer,
      device: persona.device,
      osBuildNumber: os_version,
      localeLanguageIso6391: persona.locale_language,
      localeCountryIso31661Alpha2: persona.locale_country
    }
  end

  @doc """
  Build the `DeviceProps` for `persona`.

  Includes the `historySyncConfig` block that upstream Go ships — Meta
  treats its absence as a fingerprint signal.
  """
  @spec default_device_props(Persona.t()) :: DeviceProps.t()
  def default_device_props(persona \\ Persona.configured()) do
    {a, b, c} = persona.os_version

    %DeviceProps{
      os: persona.os,
      version: %DeviceProps.AppVersion{primary: a, secondary: b, tertiary: c},
      platformType: :UNKNOWN,
      requireFullSync: false,
      historySyncConfig: default_history_sync_config()
    }
  end

  @doc false
  def default_history_sync_config do
    %DeviceProps.HistorySyncConfig{
      storageQuotaMb: 10_240,
      inlineInitialPayloadInE2EeMsg: true,
      supportCallLogHistory: false,
      supportBotUserAgentChatHistory: true,
      supportCagReactionsAndPolls: true,
      supportBizHostedMsg: true,
      supportRecentSyncChunkMessageCountTuning: true,
      supportHostedGroupMsg: true,
      supportFbidBotChatHistory: true,
      supportMessageAssociation: true,
      supportGroupHistory: true,
      thumbnailSyncDaysLimit: 60,
      supportManusHistory: true,
      supportHatchHistory: true
    }
  end

  defp identity_pub(%Device{identity_key: priv}) when byte_size(priv) == 32 do
    Whatsmeow.Crypto.Curve25519.public_for(priv)
  end

  defp signed_pre_key_pub(%Device{signed_pre_key: priv}) when byte_size(priv) == 32 do
    Whatsmeow.Crypto.Curve25519.public_for(priv)
  end

  # Parse "1234567890:1@s.whatsapp.net" → {1234567890, 1}. Also handles
  # "1234567890@s.whatsapp.net" (device defaults to 0).
  defp parse_jid_user_device(jid) when is_binary(jid) do
    [user_part | _] = String.split(jid, "@", parts: 2)

    case String.split(user_part, ":", parts: 2) do
      [u, d] -> {String.to_integer(u), String.to_integer(d)}
      [u] -> {String.to_integer(u), 0}
    end
  end
end
