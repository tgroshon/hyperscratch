defmodule HyperchatsWeb.ChatLive.Message.Form do
  use HyperchatsWeb, :live_component
  import HyperchatsWeb.CoreComponents
  alias Hyperchats.Chats
  alias Hyperchats.Chats.Message
  alias HyperchatsWeb.Endpoint

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_changeset}
  end

  def assign_changeset(socket) do
    assign(socket, :message_form, to_form(Chats.change_message(%Message{})))
  end

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        for={@message_form}
        phx-submit="save"
        phx-change="update"
        phx-target={@myself}
      >
        <.input
          autocomplete="off"
          phx-keydown={show_modal("edit_message")}
          phx-key="ArrowUp"
          phx-focus="unpin_scrollbar_from_top"
          field={@message_form[:content]}
        />
        <:actions>
          <.button>send</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("update", %{"message" => %{"content" => content}}, socket) do
    {:noreply, socket |> assign(:changeset, Chats.change_message(%Message{content: content}))}
  end

  def handle_event("save", %{"message" => %{"content" => content}}, socket) do
    {:ok, message} = Chats.create_message(%{
      content: content,
      room_id: socket.assigns.room_id,
      sender_id: socket.assigns.sender_id
    })

    Endpoint.broadcast("room:#{message.room_id}", "new_message", %{message: message})

    {:noreply, assign_changeset(socket)}
  end
end
