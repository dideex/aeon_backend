defmodule Backend.Repo.Migrations.CreateChatInvitesTable do
  use Ecto.Migration

  def change do
    create table(:chat_invites) do
      add(:user_id, references(:users))
      add(:sender_id, references(:users))
      add(:chat_id, references(:chats))

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:chat_invites, [:user_id, :chat_id]))
  end
end
