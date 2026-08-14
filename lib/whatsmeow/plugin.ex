defmodule Whatsmeow.Plugin do
  @moduledoc """
  Req-style middleware for outbound and inbound messages.

  Two pipelines, each an ordered list of **steps**:

    * `:send` — runs over an outgoing payload *before* encryption. Transform it,
      or drop it.
    * `:recv` — runs over an incoming message *after* decryption, before any
      subscriber sees it. Filter, annotate, or drop it.

  A step is `fn ctx -> {:cont, ctx} | {:halt, reason}`:

    * `{:cont, ctx}` — carry on with the (possibly modified) ctx;
    * `{:halt, reason}` — stop. On send the message is not sent and the caller
      gets `{:error, {:halted, reason}}`; on receive it is dropped and never
      broadcast.

  ## Why a pipeline rather than "just do it in your handler"

  Rate limiting, blocklists, audit logging, and content filtering all need to sit
  between the library and your code — on *every* path, including the ones you
  forget. A step you register once cannot be bypassed by a new call site, and a
  drop on the receive side means your handler never has to know the message
  existed.

  ## Registering

  Steps are global to the node and applied in registration order:

      Whatsmeow.Plugin.attach(:send, :blocklist, fn ctx ->
        if ctx.to.user in banned(), do: {:halt, :blocked}, else: {:cont, ctx}
      end)

  Register by name so re-registering replaces rather than duplicates — the usual
  failure with application-start callbacks that run twice.

  ## The ctx

  Send ctx: `%{to: %JID{}, message: %WAWebProtobufsE2E.Message{}, device_id:, opts:}`.
  Receive ctx: `%{from: %JID{}, message: %Whatsmeow.Types.Message{}, info: %MessageInfo{}, device_id:}`.

  Both are plain maps and may carry extra keys — a step that adds one hands it to
  every step after it.

  ## Failure

  A step that raises is treated as `{:cont, ctx}` and logged, not as a drop.
  A crashing audit-logger must not silently stop your messages; if a step needs
  to be fail-closed, catch inside it and return `{:halt, reason}` explicitly.
  """

  require Logger

  @type stage :: :send | :recv
  @type ctx :: map()
  @type step :: (ctx() -> {:cont, ctx()} | {:halt, term()})

  @table :whatsmeow_plugins

  @doc """
  Register `step` under `name` for `stage`, replacing any step already registered
  under that name.

  Steps run in registration order; re-registering an existing name keeps its
  original position.
  """
  @spec attach(stage(), atom(), step()) :: :ok
  def attach(stage, name, step)
      when stage in [:send, :recv] and is_atom(name) and is_function(step, 1) do
    ensure_table()
    steps = get_steps(stage)

    updated =
      case Enum.find_index(steps, fn {n, _} -> n == name end) do
        nil -> steps ++ [{name, step}]
        idx -> List.replace_at(steps, idx, {name, step})
      end

    :ets.insert(@table, {stage, updated})
    :ok
  end

  @doc "Remove the step registered under `name`."
  @spec detach(stage(), atom()) :: :ok
  def detach(stage, name) when stage in [:send, :recv] and is_atom(name) do
    ensure_table()
    :ets.insert(@table, {stage, Enum.reject(get_steps(stage), fn {n, _} -> n == name end)})
    :ok
  end

  @doc "Remove every step for `stage`, or for both stages when called with no argument."
  @spec clear(stage() | :all) :: :ok
  def clear(stage \\ :all)

  def clear(:all) do
    clear(:send)
    clear(:recv)
  end

  def clear(stage) when stage in [:send, :recv] do
    ensure_table()
    :ets.insert(@table, {stage, []})
    :ok
  end

  @doc "The names of the steps registered for `stage`, in run order."
  @spec list(stage()) :: [atom()]
  def list(stage) when stage in [:send, :recv] do
    stage |> get_steps() |> Enum.map(fn {name, _} -> name end)
  end

  @doc """
  Run `ctx` through `stage`'s pipeline.

  Returns `{:ok, ctx}` when every step continued, or `{:halt, reason}` when one
  stopped it. With no steps registered this is a map lookup and an immediate
  return — the cost on the hot path when nobody uses plugins is negligible.
  """
  @spec run(stage(), ctx()) :: {:ok, ctx()} | {:halt, term()}
  def run(stage, ctx) when stage in [:send, :recv] do
    case get_steps(stage) do
      [] -> {:ok, ctx}
      steps -> Enum.reduce_while(steps, {:ok, ctx}, &apply_step(stage, &1, &2))
    end
  end

  defp apply_step(stage, {name, step}, {:ok, ctx}) do
    case step.(ctx) do
      {:cont, %{} = next} ->
        {:cont, {:ok, next}}

      {:halt, reason} ->
        Logger.debug("[whatsmeow] #{stage} pipeline halted by #{inspect(name)}: #{inspect(reason)}")

        {:halt, {:halt, reason}}

      other ->
        Logger.warning(
          "[whatsmeow] #{stage} step #{inspect(name)} returned #{inspect(other)}; " <>
            "expected {:cont, ctx} or {:halt, reason} — continuing unchanged"
        )

        {:cont, {:ok, ctx}}
    end
  rescue
    e ->
      # Fail open. A broken audit logger must not become an outage; a step that
      # needs to be fail-closed can catch its own errors and halt explicitly.
      Logger.warning(
        "[whatsmeow] #{stage} step #{inspect(name)} raised #{Exception.message(e)}; continuing"
      )

      {:cont, {:ok, ctx}}
  end

  defp get_steps(stage) do
    ensure_table()

    case :ets.lookup(@table, stage) do
      [{^stage, steps}] -> steps
      [] -> []
    end
  rescue
    _ -> []
  end

  defp ensure_table do
    case :ets.whereis(@table) do
      :undefined -> create_table()
      _ -> :ok
    end
  end

  defp create_table do
    :ets.new(@table, [:named_table, :public, :set, read_concurrency: true])
    :ok
  rescue
    ArgumentError -> :ok
  end
end
