defmodule Hyperchats.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :content, :text
      add :payment, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:chats, [:user_id])
  end
end
