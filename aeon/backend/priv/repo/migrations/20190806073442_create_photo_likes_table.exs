defmodule Backend.Repo.Migrations.CreatePhotoLikesTable do
  use Ecto.Migration

  def change do
    create table(:photoLikes) do
      add :date, :date
      add :user_id, references(:users)
      add :photo_id, references(:photos)
    end
  end
end
