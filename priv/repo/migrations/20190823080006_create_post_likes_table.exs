defmodule Backend.Repo.Migrations.CreatePostLikesTable do
  use Ecto.Migration

  def change do
    create table(:post_likes) do
      add(:user_id, references(:users))
      add(:post_id, references(:posts))
    end

    create(unique_index(:post_likes, [:user_id, :post_id]))
  end
end
