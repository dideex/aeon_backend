defmodule Backend.Repo.Migrations.CreateUnreadMessagesTable do
  use Ecto.Migration

  def change do
    create table(:unread_messages) do
      add(:user_id, references(:users))
      add(:message_id, references(:messages))
    end

    create(unique_index(:unread_messages, [:user_id, :message_id]))
  end
end
