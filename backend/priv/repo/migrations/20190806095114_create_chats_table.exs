defmodule Backend.Repo.Migrations.CreateChatsTable do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :group, :boolean
      add :name, :string
      add :user_id, references(:users)
    end
  end
end
