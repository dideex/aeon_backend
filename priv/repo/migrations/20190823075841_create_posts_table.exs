defmodule Backend.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add(:title, :string)
      add(:body, :string)
      add(:views, :integer)
      add(:photo, :string)
      add(:author_id, references(:users))

      timestamps(inserted_at: :created_at)
    end
  end
end
