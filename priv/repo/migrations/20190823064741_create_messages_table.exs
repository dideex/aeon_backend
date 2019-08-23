defmodule Backend.Repo.Migrations.CreateMessagesTable do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add(:body, :string)
      add(:sender_id, references(:users))
      add(:chat_id, references(:chats))

      timestamps(inserted_at: :created_at)
    end
  end
end
