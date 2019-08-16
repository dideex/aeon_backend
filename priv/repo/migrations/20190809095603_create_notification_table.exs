defmodule Backend.Repo.Migrations.CreateNotificationTable do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add(:unread, :boolean)
      add(:type, :string)
      add(:title, :string)
      add(:body, :string)

      add(:user_id, references(:users))
    end
  end
end
