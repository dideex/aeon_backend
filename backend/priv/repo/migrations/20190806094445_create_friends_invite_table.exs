defmodule Backend.Repo.Migrations.CreateFriendsInviteTable do
  use Ecto.Migration

  def change do
    create table(:friend_invites) do
      # add(:user_id, references(:users))

      timestamps(inserted_at: :created_at)
    end
  end
end
