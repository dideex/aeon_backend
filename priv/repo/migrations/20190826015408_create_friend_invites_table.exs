defmodule Backend.Repo.Migrations.CreateFriendInvitesTable do
  use Ecto.Migration

  def change do
    create table(:friend_invites) do
      add(:user_id, references(:users))
      add(:sender_id, references(:users))

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:friend_invites, [:user_id, :sender_id]))
  end
end
