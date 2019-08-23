defmodule Backend.Repo.Migrations.CreateNotificationTable do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add(:title, :string)
      add(:body, :string)
      add(:type, :string)
      add(:unread, :boolean)

      add(:user_id, references(:users))

      timestamps(inserted_at: :created_at)
    end
  end
end
