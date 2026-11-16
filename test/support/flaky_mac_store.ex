defmodule Whatsmeow.Test.FlakyMacStore do
  @moduledoc """
  A `Whatsmeow.AppState.Store` that wraps the memory store but answers the first
  two `get_mutation_mac/3` calls in a process with `:not_found` whatever is stored.

  It makes the encoder and the self-check's verifying decode *disagree about the
  previous value*, which is what a codec bug would look like from outside: the
  encoded patch carries one LTHash, the verifier computes another. Used to prove
  such a patch is stopped before it reaches the wire.
  """
  @behaviour Whatsmeow.AppState.Store

  alias Whatsmeow.AppState.Store.Memory

  defdelegate put_key(jid, id, key), to: Memory
  defdelegate get_key(jid, id), to: Memory
  defdelegate latest_key_id(jid), to: Memory
  defdelegate get_version(jid, name), to: Memory
  defdelegate reset_collection(jid, name), to: Memory
  defdelegate apply_patch_state(jid, name, v, h, removed, added), to: Memory

  def get_mutation_mac(jid, name, index_mac) do
    n = Process.get(:flaky_calls, 0)
    Process.put(:flaky_calls, n + 1)
    if n < 2, do: :not_found, else: Memory.get_mutation_mac(jid, name, index_mac)
  end
end
