defmodule Backend.Repo.Migrations.CreateMessagesTable do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add(:body, :string)
      add(:unread, :boolean)
      add(:date, :date)
      add(:user_id, references(:users))
    end
  end
end
