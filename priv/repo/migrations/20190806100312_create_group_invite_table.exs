defmodule Backend.Repo.Migrations.CreateGroupInviteTable do
  use Ecto.Migration

  def change do
    create table(:chat_invites) do
      add(:user_id, references(:users))
      add(:chat_id, references(:chats))

      timestamps(inserted_at: :created_at)
    end
  end
end
