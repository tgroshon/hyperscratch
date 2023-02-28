defmodule Hyperchats.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hyperchats.Chats` context.
  """

  @doc """
  Generate a chat.
  """
  def chat_fixture(attrs \\ %{}) do
    {:ok, chat} =
      attrs
      |> Enum.into(%{
        content: "some content",
        payment: 42
      })
      |> Hyperchats.Chats.create_chat()

    chat
  end
end
