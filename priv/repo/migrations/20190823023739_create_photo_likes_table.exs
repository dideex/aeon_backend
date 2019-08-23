defmodule Backend.Repo.Migrations.CreatePhotoLikesTable do
  use Ecto.Migration

  def change do
    create table(:photo_likes) do
      add(:photo_id, references(:photos))
      add(:user_id, references(:users))
    end

    create(unique_index(:photo_likes, [:photo_id, :user_id]))
  end
end
