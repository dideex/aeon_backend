defmodule Backend.User do
  use Ecto.Schema
  require Ecto.Query
  alias Backend.User.{Photo, FriendInvite}
  alias Backend.Chat.ChatInvite
  import Ecto.Changeset
  # alias Ecto.Changeset

  @required_fields ~w(username firstname lastname birthdate hash)a
  @optional_fields ~w(gender patronymic city about)a

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

    field(:notificationPolicy, :map,
      default: %{
        show_friend_request: true,
        show_photo_rating: true,
        show_new_post: true
      }
    )

    field(:policy, :map,
      default: %{
        profile: :public,
        messages: :public
      }
    )

    field(:statistic, :map, default: %{posts: 0, likes: 0})

    has_one(:avatar, Photo)

    has_many(:friends, Backend.User)
    has_many(:ignoreUsers, Backend.User)
    has_many(:photos, Photo)
    has_many(:friend_invites, FriendInvite)
    has_many(:chat_invites, ChatInvite)

    timestamps(inserted_at: :created_at)
  end

  def changeset(user, attrs \\ {}) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
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
