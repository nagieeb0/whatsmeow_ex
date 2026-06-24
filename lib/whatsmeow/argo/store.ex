defmodule Whatsmeow.Argo.Store do
  @moduledoc """
  WhatsApp Argo query-id ↔ message-name map.

  Loads `priv/argo/name-to-queryids.json` lazily into a `:persistent_term`
  cell on first access. The map is bidirectional: callers can look up
  either direction (`query_id_for_name/1` and `name_for_query_id/1`).
  """

  @priv_subdir ["priv", "argo", "name-to-queryids.json"]
  @cache_key {__MODULE__, :tables}

  @doc """
  Resolve a friendly name (e.g. `"WAWebChatListNewsletters"`) to its
  WhatsApp query id string. Returns `nil` if unknown.
  """
  @spec query_id_for_name(String.t()) :: String.t() | nil
  def query_id_for_name(name) when is_binary(name) do
    %{name_to_id: m} = tables()
    Map.get(m, name)
  end

  @doc """
  Reverse lookup: query id → friendly name.
  """
  @spec name_for_query_id(String.t()) :: String.t() | nil
  def name_for_query_id(id) when is_binary(id) do
    %{id_to_name: m} = tables()
    Map.get(m, id)
  end

  @doc "All known message names."
  @spec names() :: [String.t()]
  def names, do: tables().name_to_id |> Map.keys()

  @doc "All known query ids."
  @spec query_ids() :: [String.t()]
  def query_ids, do: tables().id_to_name |> Map.keys()

  @doc "Force-reload the tables from disk (used by tests and the iex shell)."
  @spec reload() :: :ok
  def reload do
    :persistent_term.erase(@cache_key)
    _ = tables()
    :ok
  end

  defp tables do
    case :persistent_term.get(@cache_key, :unloaded) do
      :unloaded -> load_and_cache()
      cached -> cached
    end
  end

  defp load_and_cache do
    name_to_id =
      :whatsmeow_ex
      |> Application.app_dir(@priv_subdir)
      |> File.read!()
      |> Jason.decode!()

    id_to_name = Map.new(name_to_id, fn {n, id} -> {id, n} end)
    cached = %{name_to_id: name_to_id, id_to_name: id_to_name}
    :persistent_term.put(@cache_key, cached)
    cached
  end
end
