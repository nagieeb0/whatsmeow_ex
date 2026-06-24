defmodule Whatsmeow.Media.Conn do
  @moduledoc """
  Cache of WhatsApp media upload/download hosts + auth tokens.

  Ports the cache half of `whatsmeow-main/mediaconn.go`. The IQ exchange
  that pulls a fresh `<media_conn>` blob lands in Phase 9 once the
  protobuf-typed IQ pipeline is wired through `Whatsmeow.Session`; this
  module owns the data structure and the freshness check.

  A `Conn` is created from the parsed `<media_conn>` IQ response:

      %Whatsmeow.Media.Conn{
        auth: "Bearer ...",
        auth_ttl: 21600,
        ttl: 3600,
        max_buckets: 12,
        fetched_at: ~U[2026-05-11 13:00:00Z],
        hosts: ["mmg.whatsapp.net", "media-fra3-1.cdn.whatsapp.net"]
      }
  """

  defstruct [:auth, :auth_ttl, :ttl, :max_buckets, :fetched_at, hosts: []]

  @type t :: %__MODULE__{
          auth: String.t() | nil,
          auth_ttl: non_neg_integer() | nil,
          ttl: non_neg_integer() | nil,
          max_buckets: non_neg_integer() | nil,
          fetched_at: DateTime.t() | nil,
          hosts: [String.t()]
        }

  @doc """
  Returns the UTC timestamp at which the cache expires.
  """
  @spec expiry(t()) :: DateTime.t()
  def expiry(%__MODULE__{fetched_at: %DateTime{} = at, ttl: ttl}) when is_integer(ttl) do
    DateTime.add(at, ttl, :second)
  end

  @doc """
  Returns true when `now` (defaults to `DateTime.utc_now/0`) is at or
  past the conn's expiry.
  """
  @spec expired?(t(), DateTime.t()) :: boolean()
  def expired?(%__MODULE__{} = c, now \\ DateTime.utc_now()) do
    DateTime.compare(now, expiry(c)) != :lt
  end

  @doc """
  Build URLs for an upload/download path against the cached hosts. Picks
  the first host (the most-preferred). `path` should include the leading
  `/` and any query string.
  """
  @spec url_for(t(), String.t()) :: String.t()
  def url_for(%__MODULE__{hosts: [host | _]}, "/" <> _ = path), do: "https://" <> host <> path

  @doc """
  Return an iterable of all hosts for retry fan-out.
  """
  @spec all_urls(t(), String.t()) :: [String.t()]
  def all_urls(%__MODULE__{hosts: hosts}, "/" <> _ = path) do
    Enum.map(hosts, fn host -> "https://" <> host <> path end)
  end
end
