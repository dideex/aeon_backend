defmodule Backend.Repo.Migrations.CreateFriendsInviteTable do
  use Ecto.Migration

  def change do
    create table(:friend_invites) do
      add :date, :date
      add :user_id, references(:users)
    end
  end
end
