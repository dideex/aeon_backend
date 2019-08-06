defmodule Backend.Repo.Migrations.CreatePhotosTable do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :title, :string
      add :url, :string
      add :date, :date
      add :photo_id, references(:users)
      add :user_id, references(:users)
    end
  end
end
