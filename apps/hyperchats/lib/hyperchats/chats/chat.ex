defmodule Hyperchats.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field :content, :string
    field :payment, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:content, :payment])
    |> validate_required([:content, :payment])
  end
end
