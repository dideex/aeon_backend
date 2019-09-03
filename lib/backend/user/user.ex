defmodule Backend.User do
  use Ecto.Schema
  require Ecto.Query

  alias Backend.User.{Photo, FriendInvite, Avatar, Post, Notification, Friend, MuteUser}

  alias Backend.Chat
  import Ecto.Changeset

  @required_fields ~w(username firstname lastname birthdate password)a
  @optional_fields ~w(gender patronymic city about statistic policy notification_policy)a

  schema "users" do
    field(:username, :string, unique: true)
    field(:password, :string)
    field(:firstname, :string)
    field(:lastname, :string)
    field(:patronymic, :string)
    field(:gender, :string, default: "transgender")
    field(:city, :string)
    field(:about, :string)
    field(:birthdate, :date)

    field(:policy, :map,
      default: %{
        profile: :public,
        messages: :public
      }
    )

    field(:notification_policy, :map,
      default: %{
        show_friend_request: true,
        show_photo_rating: true,
        show_new_post: true
      }
    )

    field(:statistic, :map, default: %{posts: 0, likes: 0})

    has_one(:avatar, Avatar)
    has_many(:posts, Post, foreign_key: :author_id)
    has_many(:photos, Photo)
    has_many(:chat_owner, Chat, foreign_key: :owner_id)
    has_many(:messages, Chat.Message, foreign_key: :sender_id)
    has_many(:notifications, Notification)
    has_many(:friends, Friend)
    has_many(:chat_invites, Chat.Invite)
    has_many(:friend_invites, FriendInvite)
    has_many(:mute_users, MuteUser)
    many_to_many(:chats, Chat, join_through: "chat_members")
    many_to_many(:photo_likes, Photo, join_through: "photo_likes")
    many_to_many(:unread_messages, Chat.Message, join_through: "unread_messages")
    many_to_many(:post_likes, Post, join_through: "post_likes")

    timestamps(inserted_at: :created_at)
  end

  def changeset(user, attrs \\ {}) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> update_change(:username, &String.downcase(&1))
    |> unique_constraint(:username)
  end

  def get_first_record do
    Backend.Repo.one(Ecto.Query.from(u in __MODULE__, order_by: [asc: u.id], limit: 1))
  end

  def get_last_record do
    __MODULE__
    |> Ecto.Query.last()
    |> Backend.Repo.one()
  end
end
