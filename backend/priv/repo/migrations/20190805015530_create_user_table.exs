defmodule Backend.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :hash, :string
      add :firstname, :string
      add :lastname, :string
      add :patronymic, :string
      add :gender, :string
      add :city, :string
      add :about, :string
      add :birthdate, :date
      add :registered, :date
      add :policy, :map
      add :notificationPolicy, :map
      add :statistic, :map
    end
  end
end
