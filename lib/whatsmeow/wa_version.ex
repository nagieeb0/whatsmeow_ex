defmodule Whatsmeow.WAVersion do
  @moduledoc """
  Dynamic WhatsApp web client version resolver.

  WhatsApp's web app is versioned `{major, minor, client_revision}` where
  `client_revision` advances roughly weekly. The server rejects connects
  whose `ClientPayload.userAgent.appVersion` is too far out of date with
  `<stream:error code="500">`, so a hardcoded pin drifts into uselessness
  within days.

  This module:

  1. **Scrapes** `https://web.whatsapp.com/` for the current revision —
     same approach as upstream Go's `GetLatestVersion`. The regex matches
     a `"client_revision":N,` JSON-ish field embedded in the served HTML.
  2. **Caches** the result in `:persistent_term` under
     `#{inspect({:whatsmeow_ex, :wa_version})}` so every session
     constructed after the refresh sees the new version without process
     boundaries or message passing.
  3. **Supports proxies** via the same spec shape as the WebSocket
     transport (`Whatsmeow.Transport.WebSocket.Mint.parse_proxy/1`). In a
     multi-tenant fleet the version scrape must go through the *same*
     egress IP pool as the eventual session — different IPs can hit
     different routing layers and even briefly see different revisions.

  ## Usage

      # Boot-time refresh, direct connection:
      {:ok, version} = Whatsmeow.WAVersion.refresh()

      # Per-tenant refresh through a residential proxy:
      {:ok, version} = Whatsmeow.WAVersion.refresh(proxy: tenant_proxy_url)

      # Any caller reading the current pin:
      Whatsmeow.WAVersion.cached()
      #=> {2, 3000, 1057xxx}

  Reads are O(1) (`:persistent_term` is a hash table with no copying for
  immutable terms). Writes block briefly while the BEAM checks live
  processes for references, so call `refresh/1` at startup or on a slow
  timer — not per-message.

  ## Fallback

  When the network or proxy is unreachable, `cached/0` returns the
  hardcoded `default_version/0`. Sessions still connect; they just risk
  the same `<stream:error code="500">` we're trying to avoid.
  """

  alias Whatsmeow.Transport.WebSocket.Mint, as: MintWS

  @cache_key {:whatsmeow_ex, :wa_version}
  @default_version {2, 3000, 1_038_839_325}

  # Matches the embedded `"client_revision":NNNNN,` field in the served HTML.
  @client_revision_regex ~r/"client_revision":(\d+),/

  @host "web.whatsapp.com"
  @port 443
  @path "/"
  @default_timeout_ms 15_000

  # Browser-like headers mirroring upstream Go's GetLatestVersion. Anything
  # too far from this set risks tripping anti-bot heuristics.
  @user_agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36"

  @typep version :: {non_neg_integer(), non_neg_integer(), non_neg_integer()}

  @doc "Hardcoded fallback used when the cache is empty and no fetch has succeeded."
  @spec default_version() :: version()
  def default_version, do: @default_version

  @doc """
  Return the currently cached version, or the hardcoded default if
  nothing has been cached yet. O(1) hashtable lookup.
  """
  @spec cached() :: version()
  def cached, do: :persistent_term.get(@cache_key, @default_version)

  @doc """
  Overwrite the cached version. Writes block briefly while the BEAM
  checks references — call sparingly (startup, slow timer), not in hot
  paths.
  """
  @spec put_cached(version()) :: version()
  def put_cached({a, b, c} = version)
      when is_integer(a) and is_integer(b) and is_integer(c) do
    :persistent_term.put(@cache_key, version)
    version
  end

  @doc """
  Forget the cached version. Mostly useful in tests; production code
  should just overwrite via `put_cached/1`.
  """
  @spec clear_cache() :: :ok
  def clear_cache do
    _ = :persistent_term.erase(@cache_key)
    :ok
  end

  @doc """
  Fetch + cache the latest version in a single call. Returns
  `{:ok, version}` on success or `{:error, reason}` on failure.

  On failure the cache is **not** modified — readers continue to see
  whatever was there before (or the default).

  ## Options

  * `:proxy` — proxy spec (see `Whatsmeow.Transport.WebSocket.Mint.parse_proxy/1`).
  * `:timeout` — millisecond receive deadline (default `#{@default_timeout_ms}`).
  """
  @spec refresh(keyword()) :: {:ok, version()} | {:error, term()}
  def refresh(opts \\ []) do
    case fetch_latest(opts) do
      {:ok, version} ->
        put_cached(version)
        {:ok, version}

      {:error, _} = err ->
        err
    end
  end

  @doc """
  Fetch the latest version without touching the cache. Returns
  `{:ok, {2, 3000, revision}}` or `{:error, reason}`.

  Network errors, non-200 responses, and missing-revision cases all
  return `:error`.
  """
  @spec fetch_latest(keyword()) :: {:ok, version()} | {:error, term()}
  def fetch_latest(opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout_ms)

    with {:ok, body} <- http_get(opts, timeout),
         {:ok, revision} <- parse_revision(body) do
      {:ok, {2, 3000, revision}}
    end
  end

  @doc """
  Extract the client revision from raw HTML/JS body.

  Exposed for tests and offline diagnostics — you can paste the body
  from a `curl https://web.whatsapp.com/` capture and confirm what the
  regex sees.
  """
  @spec parse_revision(binary()) :: {:ok, pos_integer()} | {:error, :revision_not_found}
  def parse_revision(body) when is_binary(body) do
    case Regex.run(@client_revision_regex, body) do
      [_, rev_str] ->
        case Integer.parse(rev_str) do
          {n, _} when n > 0 -> {:ok, n}
          _ -> {:error, :revision_not_found}
        end

      _ ->
        {:error, :revision_not_found}
    end
  end

  # --- HTTP (Mint) ---------------------------------------------------------

  defp http_get(opts, timeout) do
    host = Keyword.get(opts, :host, @host)
    port = Keyword.get(opts, :port, @port)
    path = Keyword.get(opts, :path, @path)
    scheme = Keyword.get(opts, :scheme, :https)

    connect_opts = build_connect_opts(opts)

    with {:ok, conn} <- Mint.HTTP.connect(scheme, host, port, connect_opts),
         {:ok, conn, ref} <- Mint.HTTP.request(conn, "GET", path, request_headers(host), nil) do
      drain(conn, ref, "", timeout)
    end
  end

  defp drain(conn, ref, body_acc, timeout) do
    receive do
      message ->
        case Mint.HTTP.stream(conn, message) do
          {:ok, conn, responses} ->
            case process_responses(responses, ref, body_acc) do
              {:done, body} ->
                _ = Mint.HTTP.close(conn)
                {:ok, body}

              {:continue, body_acc} ->
                drain(conn, ref, body_acc, timeout)

              {:error, _} = err ->
                _ = Mint.HTTP.close(conn)
                err
            end

          {:error, _conn, reason, _resp} ->
            {:error, reason}

          :unknown ->
            drain(conn, ref, body_acc, timeout)
        end
    after
      timeout ->
        _ = Mint.HTTP.close(conn)
        {:error, :timeout}
    end
  end

  defp process_responses([], _ref, body), do: {:continue, body}

  defp process_responses([{:status, ref, 200} | rest], ref, body),
    do: process_responses(rest, ref, body)

  defp process_responses([{:status, ref, code} | _rest], ref, _body),
    do: {:error, {:http_status, code}}

  defp process_responses([{:headers, ref, _h} | rest], ref, body),
    do: process_responses(rest, ref, body)

  defp process_responses([{:data, ref, chunk} | rest], ref, body),
    do: process_responses(rest, ref, body <> chunk)

  defp process_responses([{:done, ref} | _rest], ref, body), do: {:done, body}

  defp process_responses([_ | rest], ref, body), do: process_responses(rest, ref, body)

  defp build_connect_opts(opts) do
    base = [protocols: [:http1]]

    case Keyword.get(opts, :proxy) do
      nil ->
        base

      spec ->
        case MintWS.parse_proxy(spec) do
          {:ok, proxy_opts} ->
            Keyword.merge(base, proxy_opts)

          {:error, reason} ->
            # Hand back a clearer error than Mint's generic failure later.
            raise ArgumentError, "invalid :proxy spec (#{inspect(reason)}): #{inspect(spec)}"
        end
    end
  end

  defp request_headers(host) do
    [
      {"host", host},
      {"user-agent", @user_agent},
      {"sec-fetch-dest", "document"},
      {"sec-fetch-mode", "navigate"},
      {"sec-fetch-site", "none"},
      {"sec-fetch-user", "?1"},
      {"accept",
       "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"},
      {"accept-language", "en-US,en;q=0.9"},
      {"connection", "close"}
    ]
  end
end
