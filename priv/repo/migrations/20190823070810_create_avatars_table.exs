defmodule Backend.Repo.Migrations.CreateAvatarsTable do
  use Ecto.Migration

  def change do
    create table(:avatars) do
      add(:title, :string)
      add(:url, :string)
      add(:user_id, references(:users))

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:avatars, [:user_id]))
  end
end
