defmodule HyperchatsWeb.ChatLive.Message.EditForm do
  use HyperchatsWeb, :live_component
  alias Hyperchats.Chats
  alias HyperchatsWeb.Endpoint

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form()}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.modal id="edit_message">
        <.simple_form
          for={@message_form}
          phx-submit={JS.push("update") |> hide_modal("edit_message")}
          phx-target={@myself}
        >
          <.input autocomplete="off" field={@message_form[:content]} />
          <:actions>
            <.button>save</.button>
          </:actions>
        </.simple_form>
      </.modal>
    </div>
    """
  end

  def handle_event("update", %{"message" => %{"content" => content}}, socket) do
    {:ok, message} = Chats.update_message(socket.assigns.message, %{content: content})

    Endpoint.broadcast("room:#{message.room_id}", "updated_message", %{message: message})

    {:noreply, socket}
  end

  def assign_form(%{assigns: %{message: message}} = socket) do
    assign(socket, :message_form, to_form(Chats.change_message(message)))
  end
end
