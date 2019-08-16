defmodule Backend.Repo.Migrations.CreateMessagesTable do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add(:body, :string)
      add(:unread, :boolean)
      add(:user_id, references(:users))
      add(:chat_id, references(:chats))
      timestamps()
    end
  end
end
