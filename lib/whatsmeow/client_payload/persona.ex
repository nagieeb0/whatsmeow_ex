defmodule Whatsmeow.ClientPayload.Persona do
  @moduledoc """
  Per-device user-agent / device-props persona.

  Drives the static fingerprint fields of `Whatsmeow.ClientPayload` so they
  resemble a real WhatsApp Web client instead of the upstream Go default
  (`os: "whatsmeow"`, `osVersion: "0.1"`, etc.) — those values are obvious
  bot tells. A persona is picked at pair time and persisted on the
  `Whatsmeow.Store.Schemas.Device` row; it must never change for a paired
  JID (changing UA across reconnects is itself a fingerprint).

  Resolution order, per device:
  1. `Device.persona` map (set at pair time)
  2. `Application.get_env(:whatsmeow_ex, :persona, ...)`
  3. Built-in `default/0` (`Mac OS`)
  """

  alias Whatsmeow.Store.Schemas.Device

  @type t :: %__MODULE__{
          os: String.t(),
          os_version: {non_neg_integer(), non_neg_integer(), non_neg_integer()},
          manufacturer: String.t(),
          device: String.t(),
          locale_language: String.t(),
          locale_country: String.t(),
          mcc: String.t(),
          mnc: String.t()
        }

  defstruct os: "Mac OS",
            os_version: {10, 15, 7},
            manufacturer: "Apple Computer, Inc.",
            device: "Desktop",
            locale_language: "en",
            locale_country: "US",
            mcc: "000",
            mnc: "000"

  @doc "Built-in default persona (modern macOS, en-US)."
  @spec default() :: t()
  def default, do: %__MODULE__{}

  # Realistic locales to spread across devices so they don't all advertise en-US.
  @locales [
    {"en", "US"},
    {"en", "GB"},
    {"pt", "BR"},
    {"es", "ES"},
    {"fr", "FR"},
    {"ar", "EG"},
    {"de", "DE"},
    {"it", "IT"},
    {"id", "ID"},
    {"tr", "TR"}
  ]

  @doc """
  A random persona — a random OS preset (macOS/Windows/Linux) with a random
  realistic locale. Assign one per device at creation so every paired number
  presents an independent device fingerprint instead of an identical one.
  Pinned on the `Device.persona` row at creation, so it stays stable across
  reconnects for that JID (a changing UA is itself a tell).
  """
  @spec random() :: t()
  def random do
    base = Enum.random([mac_os(), windows(), linux()])
    {lang, country} = Enum.random(@locales)
    %{base | locale_language: lang, locale_country: country}
  end

  @doc """
  Resolve the persona to use for `device`. Prefers the device's persisted
  persona; falls back to app-env; finally `default/0`.
  """
  @spec for_device(Device.t() | map() | nil) :: t()
  def for_device(%{persona: persona}) when is_map(persona) and map_size(persona) > 0,
    do: from_map(persona)

  def for_device(_), do: configured()

  @doc "App-env configured persona, or the built-in default."
  @spec configured() :: t()
  def configured do
    case Application.get_env(:whatsmeow_ex, :persona) do
      nil -> default()
      %__MODULE__{} = p -> p
      m when is_map(m) -> from_map(m)
    end
  end

  @doc "Build a persona from a plain (e.g. JSON-decoded) map."
  @spec from_map(map()) :: t()
  def from_map(m) when is_map(m) do
    %__MODULE__{
      os: fetch(m, :os, "Mac OS"),
      os_version: parse_version(fetch(m, :os_version, [10, 15, 7])),
      manufacturer: fetch(m, :manufacturer, "Apple Computer, Inc."),
      device: fetch(m, :device, "Desktop"),
      locale_language: fetch(m, :locale_language, "en"),
      locale_country: fetch(m, :locale_country, "US"),
      mcc: fetch(m, :mcc, "000"),
      mnc: fetch(m, :mnc, "000")
    }
  end

  @doc "Dump a persona to a plain map suitable for JSONB storage on Device.persona."
  @spec to_map(t()) :: map()
  def to_map(%__MODULE__{} = p) do
    {a, b, c} = p.os_version

    %{
      "os" => p.os,
      "os_version" => [a, b, c],
      "manufacturer" => p.manufacturer,
      "device" => p.device,
      "locale_language" => p.locale_language,
      "locale_country" => p.locale_country,
      "mcc" => p.mcc,
      "mnc" => p.mnc
    }
  end

  @doc "`osVersion` / `osBuildNumber` string ('10.15.7' style)."
  @spec os_version_string(t()) :: String.t()
  def os_version_string(%__MODULE__{os_version: {a, b, c}}), do: "#{a}.#{b}.#{c}"

  # --- Built-in presets ----------------------------------------------------

  @doc "macOS persona (`Mac OS`, 10.15.7)."
  @spec mac_os() :: t()
  def mac_os, do: %__MODULE__{}

  @doc "Windows 10 persona."
  @spec windows() :: t()
  def windows do
    %__MODULE__{
      os: "Windows",
      os_version: {10, 0, 19045},
      manufacturer: "",
      device: "Desktop"
    }
  end

  @doc "Linux persona."
  @spec linux() :: t()
  def linux do
    %__MODULE__{
      os: "Linux",
      os_version: {6, 6, 0},
      manufacturer: "",
      device: "Desktop"
    }
  end

  defp fetch(m, key, default) do
    Map.get(m, key) || Map.get(m, Atom.to_string(key)) || default
  end

  defp parse_version({a, b, c}) when is_integer(a) and is_integer(b) and is_integer(c),
    do: {a, b, c}

  defp parse_version([a, b, c]) when is_integer(a) and is_integer(b) and is_integer(c),
    do: {a, b, c}

  defp parse_version(_), do: {10, 15, 7}
end
