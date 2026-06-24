defmodule Whatsmeow.Newsletter do
  @moduledoc """
  WhatsApp Channel (newsletter) live operations.

  The full upstream Newsletter API includes CRUD + discovery via MEX
  (`xmlns="w:mex"`) GraphQL-style queries that require a query-id table +
  JSON variables / responses. This module ships the **direct-IQ** subset
  any channel bot actually needs:

  * subscribe to live updates (temporary per-session subscription)
  * mark a message as viewed (increments WhatsApp's view counter)
  * send / remove a reaction

  Mirrors `whatsmeow-main/newsletter.go`. The MEX-based CreateNewsletter /
  FollowNewsletter / GetNewsletterMessages family is a follow-up — they
  need the `argo` self-describing-codec wired into a GraphQL query layer.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Session
  alias Whatsmeow.Types.JID

  @namespace "newsletter"
  @default_timeout 30_000

  # --- Builders --------------------------------------------------------------

  @doc """
  Build a `<iq xmlns="newsletter"><live_updates/></iq>` requesting live
  updates from a channel for the duration the server allows (usually a few
  minutes).

  Mirrors Go's `NewsletterSubscribeLiveUpdates` (`newsletter.go:28`).
  """
  @spec build_subscribe_live_updates_iq(JID.t() | String.t(), keyword()) :: Node.t()
  def build_subscribe_live_updates_iq(channel_jid, opts \\ []) do
    {:ok, jid} = to_newsletter_jid(channel_jid)
    id = Keyword.get(opts, :id) || IQ.generate_id()

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => jid,
        "type" => "set",
        "xmlns" => @namespace
      },
      [Node.new("live_updates", %{}, nil)]
    )
  end

  @doc """
  Build a `<receipt type="view">` marking channel messages as viewed.

  `server_ids` are the integer server-side message ids (different shape
  from the standard `MessageID` string — they come from `<message>` attrs
  on inbound newsletter messages as `server_id="…"`).

  Mirrors Go's `NewsletterMarkViewed` (`newsletter.go:48`).
  """
  @spec build_mark_viewed_node(JID.t() | String.t(), [integer() | String.t()], keyword()) ::
          Node.t()
  def build_mark_viewed_node(channel_jid, server_ids, opts \\ []) when is_list(server_ids) do
    {:ok, jid} = to_newsletter_jid(channel_jid)
    id = Keyword.get(opts, :id) || IQ.generate_id()

    items =
      Enum.map(server_ids, fn server_id ->
        Node.new("item", %{"server_id" => to_string(server_id)}, nil)
      end)

    Node.new(
      "receipt",
      %{
        "to" => jid,
        "type" => "view",
        "id" => id
      },
      [Node.new("list", %{}, items)]
    )
  end

  @doc """
  Build a `<message type="reaction">` node sending (or removing) a reaction
  to a channel message identified by `server_id`.

  Passing an empty string for `reaction` removes a prior reaction (adds an
  `edit="7"` sender-revoke attr).

  Mirrors Go's `NewsletterSendReaction` (`newsletter.go:88`).
  """
  @spec build_send_reaction_node(
          JID.t() | String.t(),
          integer() | String.t(),
          String.t(),
          keyword()
        ) :: Node.t()
  def build_send_reaction_node(channel_jid, server_id, reaction, opts \\ [])
      when is_binary(reaction) do
    {:ok, jid} = to_newsletter_jid(channel_jid)
    msg_id = Keyword.get(opts, :message_id) || Whatsmeow.Send.generate_message_id()

    base_msg_attrs = %{
      "to" => jid,
      "id" => msg_id,
      "server_id" => to_string(server_id),
      "type" => "reaction"
    }

    msg_attrs =
      if reaction == "",
        do: Map.put(base_msg_attrs, "edit", "7"),
        else: base_msg_attrs

    reaction_attrs = if reaction == "", do: %{}, else: %{"code" => reaction}

    Node.new(
      "message",
      msg_attrs,
      [Node.new("reaction", reaction_attrs, nil)]
    )
  end

  # --- Live wrappers ---------------------------------------------------------

  @doc """
  Subscribe to live updates from `channel_jid`. Returns the subscription
  duration in seconds (the server limits to ~5-15 minutes per call).

  After the duration elapses, no more updates will arrive until you call
  `subscribe_live_updates/2` again.
  """
  @spec subscribe_live_updates(pid() | String.t(), JID.t() | String.t(), keyword()) ::
          {:ok, non_neg_integer()} | {:error, term()}
  def subscribe_live_updates(session, channel_jid, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)
    iq = build_subscribe_live_updates_iq(channel_jid, opts)

    with {:ok, resp} <- Session.send_iq(session, iq, timeout),
         %Node{} = lu <- Node.get_child(resp, "live_updates") do
      duration =
        case Node.attr(lu, "duration") do
          n when is_integer(n) -> n
          s when is_binary(s) -> elem(Integer.parse(s), 0)
          _ -> 0
        end

      {:ok, duration}
    else
      nil -> {:error, :missing_live_updates_node}
      err -> err
    end
  end

  @doc """
  Mark one or more channel messages as viewed.

  This bumps WhatsApp's per-message view counter; it's distinct from the
  per-device read marker (which is handled by `Whatsmeow.Receipt`).
  """
  @spec mark_viewed(pid() | String.t(), JID.t() | String.t(), [integer() | String.t()], keyword()) ::
          :ok | {:error, term()}
  def mark_viewed(session, channel_jid, server_ids, opts \\ []) do
    node = build_mark_viewed_node(channel_jid, server_ids, opts)
    Session.send_node(session, node)
  end

  @doc """
  Send or remove a reaction to a channel message. Pass `""` to remove.
  """
  @spec send_reaction(
          pid() | String.t(),
          JID.t() | String.t(),
          integer() | String.t(),
          String.t(),
          keyword()
        ) :: :ok | {:error, term()}
  def send_reaction(session, channel_jid, server_id, reaction, opts \\ []) do
    node = build_send_reaction_node(channel_jid, server_id, reaction, opts)
    Session.send_node(session, node)
  end

  # --- Helpers ---------------------------------------------------------------

  defp to_newsletter_jid(%JID{server: "newsletter"} = j), do: {:ok, j}

  defp to_newsletter_jid(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, %JID{server: "newsletter"} = j} -> {:ok, j}
      {:ok, _} -> {:error, :not_a_newsletter_jid}
      err -> err
    end
  end

  defp to_newsletter_jid(_), do: {:error, :not_a_newsletter_jid}
end
