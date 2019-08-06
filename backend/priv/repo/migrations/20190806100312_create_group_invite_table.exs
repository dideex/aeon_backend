defmodule Backend.Repo.Migrations.CreateGroupInviteTable do
  use Ecto.Migration

  def change do
    create table(:group_invites) do
      add :date, :date
      add :user_id, references(:users)
      add :chat_id, references(:chats)
    end
  end
end
