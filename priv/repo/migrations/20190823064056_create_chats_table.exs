defmodule Backend.Repo.Migrations.CreateChatsTable do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add(:name, :string)
      add(:image, :string)
      add(:group, :boolean)
      add(:owner_id, references(:users))

      timestamps(inserted_at: :created_at)
    end
  end
end
