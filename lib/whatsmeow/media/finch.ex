defmodule Whatsmeow.Media.Finch do
  @moduledoc """
  Finch wrapper for streaming media upload/download.

  WhatsApp media payloads can run into 100MB+ (videos, documents). Even
  though our crypto helpers in `Whatsmeow.Media.{Upload,Download}` work
  on a fully buffered binary today, the network round-trip must use
  `Finch.stream/4` to avoid loading the whole body into a single VM
  message buffer.

  Callers are expected to start a Finch instance under their own
  supervision tree:

      {Finch, name: Whatsmeow.Finch}

  ## Streaming download

  `stream_get/2` returns the body via a fold-style accumulator so the
  caller can keep an HMAC-SHA256 / SHA-256 running without ever holding
  the full ciphertext in memory.

      Whatsmeow.Media.Finch.stream_get(url, fn
        {:status, code}, acc -> %{acc | status: code}
        {:headers, h}, acc -> %{acc | headers: h}
        {:data, chunk}, acc -> %{acc | size: acc.size + byte_size(chunk)}
      end, %{status: 0, headers: [], size: 0})

  **The reducer returns the accumulator itself, bare.** `stream_get/2` is
  `Finch.stream/5`, which adds the `{:cont, _}` for you; only
  `Finch.stream_while/5` takes a reducer that wraps its own return. Getting
  this backwards does not raise on the first message — it raises on the
  first `{:data, _}`, several frames later, as a `BadMapError` naming an
  accumulator nested inside two `:cont` tuples. That shipped, and it broke
  every media download and every history sync on every host.

  ## Streaming upload

  `stream_put/3` accepts an `{:stream, enumerable}` body so the caller
  can pipe iodata directly into the request without `IO.iodata_to_binary/1`.
  """

  @finch_name Application.compile_env(:whatsmeow_ex, :finch_name, Whatsmeow.Finch)

  @type stream_acc :: term()
  @type stream_fun :: (Finch.stream_message(), stream_acc() -> stream_acc())

  @doc """
  Perform a streaming GET. `fun` receives `{:status, code}`,
  `{:headers, headers}`, and `{:data, binary}` messages.

  Returns `{:ok, final_acc}` or `{:error, reason}`.
  """
  @spec stream_get(String.t(), stream_fun(), stream_acc(), keyword()) ::
          {:ok, stream_acc()} | {:error, term()}
  def stream_get(url, fun, acc0, opts \\ []) when is_binary(url) and is_function(fun, 2) do
    headers = Keyword.get(opts, :headers, [])

    Finch.build(:get, url, headers)
    |> Finch.stream(@finch_name, acc0, fun)
  end

  @doc """
  Perform a streaming PUT with an iodata-producing enumerable as the
  request body. The enumerable is consumed lazily by Finch.

  Returns `{:ok, %Finch.Response{}}` or `{:error, reason}`.
  """
  @spec stream_put(String.t(), Enumerable.t(), keyword()) ::
          {:ok, Finch.Response.t()} | {:error, term()}
  def stream_put(url, enumerable, opts \\ []) when is_binary(url) do
    headers = Keyword.get(opts, :headers, [])

    Finch.build(:put, url, headers, {:stream, enumerable})
    |> Finch.request(@finch_name)
  end

  @doc """
  Convenience: stream the response body as a list of iodata chunks back
  to the caller. Useful when callers want to keep `stream/4` semantics
  but plug into existing buffered code paths.
  """
  @spec collect_body(String.t(), keyword()) ::
          {:ok, status :: integer(), iodata()} | {:error, term()}
  def collect_body(url, opts \\ []) when is_binary(url) do
    headers = Keyword.get(opts, :headers, [])

    acc0 = %{status: 0, body: []}

    fun = fn
      {:status, code}, acc -> {:cont, %{acc | status: code}}
      {:headers, _}, acc -> {:cont, acc}
      {:data, chunk}, acc -> {:cont, %{acc | body: [acc.body, chunk]}}
    end

    case Finch.build(:get, url, headers) |> Finch.stream_while(@finch_name, acc0, fun) do
      {:ok, %{status: status, body: iodata}} -> {:ok, status, iodata}
      # `stream_while/5` reports a failure as a *three*-tuple carrying whatever
      # had been collected before it. `stream/5` does not, so this clause never
      # existed and a mid-transfer error arrived at `fetch_one/2` as a shape its
      # `case` had no clause for — a second, quieter version of the same bug.
      {:error, error, _partial} -> {:error, error}
      err -> err
    end
  end
end
