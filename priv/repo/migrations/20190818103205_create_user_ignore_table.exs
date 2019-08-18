defmodule Backend.Repo.Migrations.CreateUserIgnoreTable do
  use Ecto.Migration

  def change do
    create table(:user_ignores) do
      add(:user, references(:users), primary_key: true)
      add(:user_ignore, references(:users), primary_key: true)

      timestamps(updated_at: false)
    end

    create(index(:user_ignores, [:user]))
    create(index(:user_ignores, [:user_ignore]))
  end
end
