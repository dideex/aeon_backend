defmodule Backend.Repo.Migrations.CreatePostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :string
      add :views, :integer
      add :date, :date
      add :user_id, references(:users)
    end
  end
end
