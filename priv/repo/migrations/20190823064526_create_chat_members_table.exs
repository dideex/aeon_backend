defmodule Backend.Repo.Migrations.CreateChatMembersTable do
  use Ecto.Migration

  def change do
    create table(:chat_members) do
      add(:chat_id, references(:chats))
      add(:user_id, references(:users))
    end

    create(unique_index(:chat_members, [:chat_id, :user_id]))
  end
end
