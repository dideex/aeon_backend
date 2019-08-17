defmodule Backend.Repo.Migrations.CreatePhotosTable do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add(:title, :string)
      add(:url, :string)
      add(:user_id, references(:users))

      timestamps(inserted_at: :created_at)
    end
  end
end
