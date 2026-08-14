defmodule Whatsmeow.Types.JID do
  @moduledoc """
  A WhatsApp JID (Jabber ID).

  Two flavours exist on the wire:

  * **Regular JID** — `user@server` for users, groups, broadcasts,
    newsletters. The `user` may be empty (the server itself).
  * **AD-JID** — `user.agent:device@server`, used to address a specific
    device of a user. The server for AD-JIDs is normally `s.whatsapp.net`.

  Known servers:

  | Server          | Constant            |
  | --------------- | ------------------- |
  | `s.whatsapp.net`| `default_user_server/0` (phone-number users) |
  | `lid`           | `hidden_user_server/0` (linked-device IDs)   |
  | `g.us`          | `group_server/0`                              |
  | `broadcast`     | `broadcast_server/0`                          |
  | `newsletter`    | `newsletter_server/0`                         |
  | `bot`           | `bot_server/0`                                |
  | `c.us`          | `legacy_user_server/0`                        |
  | `msgr`          | `messenger_server/0`                          |
  | `interop`       | `interop_server/0`                            |
  | `hosted`        | `hosted_server/0`                             |
  | `hosted.lid`    | `hosted_lid_server/0`                         |

  ## Parsing

  `parse/1` never converts user-supplied strings into atoms (Iron Law —
  atom-exhaustion DoS). Server strings remain binaries.
  """

  @enforce_keys [:server]
  defstruct user: "", agent: 0, device: 0, integrator: 0, server: ""

  @type t :: %__MODULE__{
          user: String.t(),
          agent: non_neg_integer(),
          device: non_neg_integer(),
          integrator: non_neg_integer(),
          server: String.t()
        }

  # --- Known servers ---------------------------------------------------------

  @default_user_server "s.whatsapp.net"
  @group_server "g.us"
  @legacy_user_server "c.us"
  @broadcast_server "broadcast"
  @hidden_user_server "lid"
  @messenger_server "msgr"
  @interop_server "interop"
  @newsletter_server "newsletter"
  @hosted_server "hosted"
  @hosted_lid_server "hosted.lid"
  @bot_server "bot"

  def default_user_server, do: @default_user_server
  def group_server, do: @group_server
  def legacy_user_server, do: @legacy_user_server
  def broadcast_server, do: @broadcast_server
  def hidden_user_server, do: @hidden_user_server
  def messenger_server, do: @messenger_server
  def interop_server, do: @interop_server
  def newsletter_server, do: @newsletter_server
  def hosted_server, do: @hosted_server
  def hosted_lid_server, do: @hosted_lid_server
  def bot_server, do: @bot_server

  # --- Constructors ----------------------------------------------------------

  @doc "Build a regular (non-AD) JID for the given user/server pair."
  @spec new(String.t(), String.t()) :: t()
  def new(user, server) when is_binary(user) and is_binary(server) do
    %__MODULE__{user: user, server: server}
  end

  @doc """
  Build an AD-JID — `user.agent:device@<server>` where `<server>` is derived
  from the agent's domain type:

      | agent       | server         |
      | ----------- | -------------- |
      | 0 (whatsapp)| s.whatsapp.net |
      | 1 (lid)     | lid            |
      | 128 (hosted)| hosted         |
      | 129 (hosted lid) | hosted.lid|
      | other       | s.whatsapp.net (raw agent retained) |
  """
  @spec new_ad(String.t(), non_neg_integer(), non_neg_integer()) :: t()
  def new_ad(user, agent, device)
      when is_binary(user) and is_integer(agent) and agent >= 0 and agent <= 255 and
             is_integer(device) and device >= 0 and device <= 65_535 do
    case agent do
      1 -> %__MODULE__{user: user, agent: 0, device: device, server: @hidden_user_server}
      128 -> %__MODULE__{user: user, agent: 0, device: device, server: @hosted_server}
      129 -> %__MODULE__{user: user, agent: 0, device: device, server: @hosted_lid_server}
      raw -> %__MODULE__{user: user, agent: raw, device: device, server: @default_user_server}
    end
  end

  # --- Parsing ---------------------------------------------------------------

  @doc """
  Parse a string into a `t:t/0`. Returns `{:ok, jid}` or `{:error, reason}`.

  ## Examples

      iex> Whatsmeow.Types.JID.parse("447400000000@s.whatsapp.net")
      {:ok, %Whatsmeow.Types.JID{user: "447400000000", server: "s.whatsapp.net"}}

      iex> Whatsmeow.Types.JID.parse("447400000000.0:1@s.whatsapp.net")
      {:ok, %Whatsmeow.Types.JID{user: "447400000000", device: 1, server: "s.whatsapp.net"}}

      iex> Whatsmeow.Types.JID.parse("447400000000:2@s.whatsapp.net")
      {:ok, %Whatsmeow.Types.JID{user: "447400000000", device: 2, server: "s.whatsapp.net"}}

      iex> Whatsmeow.Types.JID.parse("g.us")
      {:ok, %Whatsmeow.Types.JID{server: "g.us"}}
  """
  @spec parse(String.t()) :: {:ok, t()} | {:error, atom()}
  def parse(input) when is_binary(input) do
    case String.split(input, "@", parts: 2) do
      [server] -> {:ok, %__MODULE__{user: "", server: server}}
      [user_part, server] -> parse_user_part(user_part, server)
    end
  end

  defp parse_user_part(user_part, server) do
    cond do
      String.contains?(user_part, ".") -> parse_ad_form(user_part, server)
      String.contains?(user_part, ":") -> parse_device_only(user_part, server)
      true -> {:ok, %__MODULE__{user: user_part, server: server}}
    end
  end

  defp parse_ad_form(user_part, server) do
    case String.split(user_part, ".") do
      [user, agent_device] -> parse_agent_device(user, agent_device, server)
      _ -> {:error, :unexpected_dot_count}
    end
  end

  defp parse_agent_device(user, agent_device, server) do
    case String.split(agent_device, ":") do
      [agent_s] ->
        with {:ok, agent} <- parse_uint(agent_s, 255) do
          {:ok, %__MODULE__{user: user, agent: agent, server: server}}
        end

      [agent_s, device_s] ->
        with {:ok, agent} <- parse_uint(agent_s, 255),
             {:ok, device} <- parse_uint(device_s, 65_535) do
          {:ok, %__MODULE__{user: user, agent: agent, device: device, server: server}}
        end

      _ ->
        {:error, :unexpected_colon_count}
    end
  end

  defp parse_device_only(user_part, server) do
    case String.split(user_part, ":") do
      [user, device_s] ->
        with {:ok, device} <- parse_uint(device_s, 65_535) do
          {:ok, %__MODULE__{user: user, device: device, server: server}}
        end

      _ ->
        {:error, :unexpected_colon_count}
    end
  end

  defp parse_uint(s, max) do
    case Integer.parse(s) do
      {n, ""} when n >= 0 and n <= max -> {:ok, n}
      _ -> {:error, :invalid_integer}
    end
  end

  @doc "Like `parse/1`, but raises on error."
  @spec parse!(String.t()) :: t()
  def parse!(input) do
    case parse(input) do
      {:ok, jid} -> jid
      {:error, reason} -> raise ArgumentError, "invalid JID #{inspect(input)}: #{reason}"
    end
  end

  # --- Formatting ------------------------------------------------------------

  @doc "Format a JID as the canonical wire string."
  @spec to_string(t()) :: String.t()
  def to_string(%__MODULE__{} = jid) do
    cond do
      jid.agent > 0 -> "#{jid.user}.#{jid.agent}:#{jid.device}@#{jid.server}"
      jid.device > 0 -> "#{jid.user}:#{jid.device}@#{jid.server}"
      jid.user != "" -> "#{jid.user}@#{jid.server}"
      true -> jid.server
    end
  end

  @doc "Strip agent + device, returning a regular JID."
  @spec to_non_ad(t()) :: t()
  def to_non_ad(%__MODULE__{} = jid) do
    %__MODULE__{user: jid.user, integrator: jid.integrator, server: jid.server}
  end

  @doc "Empty JIDs have no server."
  @spec empty?(t()) :: boolean()
  def empty?(%__MODULE__{server: ""}), do: true
  def empty?(%__MODULE__{}), do: false

  @doc "Convert the user component to integer (only meaningful for phone-number users)."
  @spec user_int(t()) :: non_neg_integer() | nil
  def user_int(%__MODULE__{user: u}) do
    case Integer.parse(u) do
      {n, ""} when n >= 0 -> n
      _ -> nil
    end
  end

  @doc """
  True for WhatsApp's own bot accounts (Meta AI and friends).

  Mirrors Go's `JID.IsBot` (`whatsmeow-main/types/jid.go:127`): either the
  dedicated `@bot` server, or one of the reserved phone-number ranges on the
  normal user server with no device suffix.
  """
  @spec bot?(t()) :: boolean()
  def bot?(%__MODULE__{server: @bot_server}), do: true

  def bot?(%__MODULE__{server: @default_user_server, user: user, device: device})
      when device in [0, nil] do
    Regex.match?(~r/^1313555\d{4}$|^131655500\d{2}$/, user)
  end

  def bot?(%__MODULE__{}), do: false

  @doc "The public-service-announcement JID (`0@s.whatsapp.net`)."
  @spec psa_user() :: String.t()
  def psa_user, do: "0"

  @doc "Return the domain-type byte that whatsmeow uses for the Noise client payload."
  @spec actual_agent(t()) :: 0 | 1 | 128 | 129 | non_neg_integer()
  def actual_agent(%__MODULE__{server: @default_user_server}), do: 0
  def actual_agent(%__MODULE__{server: @hidden_user_server}), do: 1
  def actual_agent(%__MODULE__{server: @hosted_server}), do: 128
  def actual_agent(%__MODULE__{server: @hosted_lid_server}), do: 129
  def actual_agent(%__MODULE__{agent: a}), do: a

  defimpl String.Chars do
    def to_string(jid), do: Whatsmeow.Types.JID.to_string(jid)
  end

  defimpl Inspect do
    import Inspect.Algebra

    def inspect(jid, _opts) do
      concat(["#JID<", Whatsmeow.Types.JID.to_string(jid), ">"])
    end
  end
end
