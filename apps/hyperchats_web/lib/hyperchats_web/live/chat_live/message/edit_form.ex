defmodule HyperchatsWeb.ChatLive.Message.EditForm do
  use HyperchatsWeb, :live_component
  alias Hyperchats.Chats

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_changeset()}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.modal id="edit_message">
        <.simple_form
          :let={f}
          for={@changeset}
          phx-submit={JS.push("update") |> hide_modal("edit_message")}
          phx-target={@myself}
        >
          <.input autocomplete="off" field={{f, :content}} />
          <:actions>
            <.button>save</.button>
          </:actions>
        </.simple_form>
      </.modal>
    </div>
    """
  end

  def handle_event("update", %{"message" => %{"content" => content}}, socket) do
    Chats.update_message(socket.assigns.message, %{content: content})

    {:noreply, socket}
  end

  def assign_changeset(%{assigns: %{message: message}} = socket) do
    assign(socket, :changeset, Chats.change_message(message))
  end
end
