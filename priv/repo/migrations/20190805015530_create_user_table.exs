defmodule Backend.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string)
      add(:password, :string)
      add(:firstname, :string)
      add(:lastname, :string)
      add(:patronymic, :string)
      add(:gender, :string)
      add(:city, :string)
      add(:about, :string)
      add(:birthdate, :date)
      add(:policy, :map)
      add(:notification_policy, :map)
      add(:statistic, :map)

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:users, [:username]))
  end
end
