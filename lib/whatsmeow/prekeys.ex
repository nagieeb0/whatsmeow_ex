defmodule Whatsmeow.PreKeys do
  @moduledoc """
  One-time pre-key (OPK) management — generation, upload, and lookup.

  Ports `whatsmeow-main/prekeys.go`. Without an OPK pool published to
  the server, peers who try to message us for the first time get an
  empty response from `<iq xmlns="encrypt" type="get">` and silently
  fail their X3DH bootstrap. WhatsApp expects a fresh device to upload
  a large batch (`@initial_upload_count`) immediately after pairing
  and to top the pool back up to `@wanted_count` whenever the
  server-side count drops below `@min_count`.

  ## Wire shape

  Upload (`<iq type="set" xmlns="encrypt">`):

      <iq type="set" xmlns="encrypt" to="s.whatsapp.net" id="…">
        <registration>...4 bytes BE...</registration>
        <type>0x05</type>           # DjbType byte
        <identity>...32 bytes...</identity>
        <list>
          <key>
            <id>...3 bytes BE...</id>
            <value>...32 bytes pub...</value>
          </key>
          ...
        </list>
        <skey>
          <id>...3 bytes BE...</id>
          <value>...32 bytes pub...</value>
          <signature>...64 bytes XEdDSA sig...</signature>
        </skey>
      </iq>

  ## Persistence

  Generated OPKs persist to `whatsmeow_pre_keys` with `uploaded=false`,
  get flipped to `true` once the server acks the upload. The private
  half is needed to decrypt future `<enc type="pkmsg">` envelopes that
  reference this `preKeyId`.
  """

  require Logger

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.IQ
  alias Whatsmeow.Session
  alias Whatsmeow.Store.Schemas.{Device, PreKey}

  @server_jid "s.whatsapp.net"
  @djb_type 0x05

  # WhatsApp's published constants (`whatsmeow-main/prekeys.go:27-29`).
  @wanted_count 50
  @min_count 5
  @initial_upload_count 812

  @typedoc "A locally-generated one-time pre-key: id + 32-byte private."
  @type prekey :: %{key_id: non_neg_integer(), priv: <<_::256>>, pub: <<_::256>>}

  @doc "Per-upload batch size when topping up an already-paired account."
  @spec wanted_count() :: pos_integer()
  def wanted_count, do: @wanted_count

  @doc "Threshold at which the client should refill OPKs."
  @spec min_count() :: pos_integer()
  def min_count, do: @min_count

  @doc "Initial-upload count for a freshly-paired account."
  @spec initial_upload_count() :: pos_integer()
  def initial_upload_count, do: @initial_upload_count

  # ---------------------------------------------------------------------
  #  Key generation
  # ---------------------------------------------------------------------

  @doc """
  Generate `count` fresh OPKs starting at `start_id`.

  Pure / stateless — the caller persists the returned list and tracks
  the next id. `pub` is derived from the private scalar via Curve25519
  (we don't store the public separately; recomputing is cheap).
  """
  @spec generate(non_neg_integer(), non_neg_integer()) :: [prekey()]
  def generate(count, start_id) when is_integer(count) and count > 0 and is_integer(start_id) do
    for offset <- 0..(count - 1) do
      {pub, priv} = Curve25519.generate_keypair()
      %{key_id: start_id + offset, priv: priv, pub: pub}
    end
  end

  # ---------------------------------------------------------------------
  #  Upload IQ builder
  # ---------------------------------------------------------------------

  @doc """
  Build the `<iq type="set" xmlns="encrypt">` upload request.

  `device` must carry the live `identity_key`, `signed_pre_key`,
  `signed_pre_key_id`, `signed_pre_key_sig`, and `registration_id`.

  `iq_id` lets callers reuse a parked id (for replay) — defaults to a
  fresh one via `IQ.generate_id/0`.
  """
  @spec build_upload_iq([prekey()], Device.t(), String.t() | nil) :: Node.t()
  def build_upload_iq(prekeys, %Device{} = device, iq_id \\ nil) when is_list(prekeys) do
    id = iq_id || IQ.generate_id()
    identity_pub = Curve25519.public_for(device.identity_key)
    signed_pre_key_pub = Curve25519.public_for(device.signed_pre_key)
    reg_bytes = <<device.registration_id::big-unsigned-32>>

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => @server_jid,
        "type" => "set",
        "xmlns" => "encrypt"
      },
      [
        Node.new("registration", %{}, reg_bytes),
        Node.new("type", %{}, <<@djb_type>>),
        Node.new("identity", %{}, identity_pub),
        Node.new("list", %{}, Enum.map(prekeys, &prekey_to_node/1)),
        signed_pre_key_node(
          device.signed_pre_key_id,
          signed_pre_key_pub,
          device.signed_pre_key_sig
        )
      ]
    )
  end

  @doc false
  # Encode a one-time pre-key as `<key><id/><value/></key>`. The id is a
  # 3-byte big-endian unsigned int — same width libsignal-protocol-java
  # uses to keep the field below 2^24.
  @spec prekey_to_node(prekey()) :: Node.t()
  def prekey_to_node(%{key_id: id, priv: priv}) when is_integer(id) do
    pub = Curve25519.public_for(priv)

    Node.new("key", %{}, [
      Node.new("id", %{}, <<id::big-unsigned-24>>),
      Node.new("value", %{}, pub)
    ])
  end

  @doc false
  @spec signed_pre_key_node(non_neg_integer(), <<_::256>>, <<_::512>>) :: Node.t()
  def signed_pre_key_node(key_id, pub, sig) when byte_size(pub) == 32 and byte_size(sig) == 64 do
    Node.new("skey", %{}, [
      Node.new("id", %{}, <<key_id::big-unsigned-24>>),
      Node.new("value", %{}, pub),
      Node.new("signature", %{}, sig)
    ])
  end

  # ---------------------------------------------------------------------
  #  Persistence — get-or-generate, mark uploaded
  # ---------------------------------------------------------------------

  @doc """
  Return up to `count` unuploaded OPKs for `our_jid`. Generates and
  persists fresh ones if the pool falls short.

  Returns `{:ok, [%{key_id, priv, pub}]}` on success or
  `{:error, :no_repo}` when Postgres isn't reachable (tests).
  """
  @spec get_or_generate(String.t(), pos_integer()) ::
          {:ok, [prekey()]} | {:error, :no_repo | term()}
  def get_or_generate(our_jid, count) when is_binary(our_jid) and count > 0 do
    if repo_up?() do
      do_get_or_generate(our_jid, count)
    else
      {:error, :no_repo}
    end
  rescue
    e -> {:error, {:repo, Exception.message(e)}}
  end

  defp do_get_or_generate(our_jid, count) do
    import Ecto.Query

    existing =
      from(p in PreKey, where: p.jid == ^our_jid and p.uploaded == false, order_by: p.key_id)
      |> Whatsmeow.Repo.all()

    needed = count - length(existing)

    fresh =
      if needed > 0 do
        start_id = next_id(our_jid)
        keys = generate(needed, start_id)
        _ = Enum.each(keys, &persist_prekey(our_jid, &1))
        keys
      else
        []
      end

    pool =
      existing
      |> Enum.map(&row_to_prekey/1)
      |> Kernel.++(fresh)
      |> Enum.take(count)

    {:ok, pool}
  end

  defp row_to_prekey(%PreKey{key_id: id, key: priv}) do
    %{key_id: id, priv: priv, pub: Curve25519.public_for(priv)}
  end

  defp next_id(our_jid) do
    import Ecto.Query

    from(p in PreKey, where: p.jid == ^our_jid, select: max(p.key_id))
    |> Whatsmeow.Repo.one()
    |> case do
      nil -> 1
      n when is_integer(n) -> n + 1
    end
  end

  defp persist_prekey(our_jid, %{key_id: id, priv: priv}) do
    %PreKey{}
    |> PreKey.changeset(%{jid: our_jid, key_id: id, key: priv, uploaded: false})
    |> Whatsmeow.Repo.insert(
      on_conflict: {:replace, [:key, :uploaded]},
      conflict_target: [:jid, :key_id]
    )
  end

  @doc """
  Mark every OPK up to and including `max_key_id` as uploaded.

  Called after the server acks an `uploadPreKeys` IQ — mirrors Go's
  `MarkPreKeysAsUploaded`.
  """
  @spec mark_uploaded(String.t(), non_neg_integer()) :: {:ok, integer()} | {:error, term()}
  def mark_uploaded(our_jid, max_key_id)
      when is_binary(our_jid) and is_integer(max_key_id) and max_key_id > 0 do
    if repo_up?() do
      import Ecto.Query

      {n, _} =
        from(p in PreKey, where: p.jid == ^our_jid and p.key_id <= ^max_key_id)
        |> Whatsmeow.Repo.update_all(set: [uploaded: true])

      {:ok, n}
    else
      {:error, :no_repo}
    end
  rescue
    e -> {:error, {:repo, Exception.message(e)}}
  end

  # ---------------------------------------------------------------------
  #  Orchestration — fetch/generate, send IQ, mark uploaded
  # ---------------------------------------------------------------------

  @doc """
  Run a full pre-key upload cycle against the running `server`.

  Uses `initial_upload_count/0` worth of keys for the first upload of a
  newly-paired device; otherwise tops up to `wanted_count/0`.

  Returns `{:ok, %{uploaded: n, response: iq_node}}` on success.

      iex> Whatsmeow.PreKeys.upload(session, initial?: true)

  Resp shape from the server is `<iq type="result"/>` with no payload.
  """
  @spec upload(pid() | String.t(), keyword()) ::
          {:ok, %{uploaded: non_neg_integer(), response: Node.t()}}
          | {:error, term()}
  def upload(server, opts \\ []) do
    initial? = Keyword.get(opts, :initial?, false)
    count = if initial?, do: @initial_upload_count, else: @wanted_count
    timeout = Keyword.get(opts, :timeout, 30_000)

    with {:ok, %Device{} = device} <- Session.get_device(server),
         {:ok, prekeys} <- get_or_generate(device.jid, count) do
      iq = build_upload_iq(prekeys, device)

      case Session.send_iq(server, iq, timeout) do
        {:ok, %Node{tag: "iq"} = response} ->
          last_id = prekeys |> List.last() |> Map.get(:key_id)
          _ = mark_uploaded(device.jid, last_id)
          {:ok, %{uploaded: length(prekeys), response: response}}

        {:error, _} = err ->
          err
      end
    end
  end

  defp repo_up? do
    Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))
  end
end
