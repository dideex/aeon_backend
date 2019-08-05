defmodule Backend.User do
  use Ecto.Schema
  require Ecto.Query
  # alias Ecto.Changeset

  schema "users" do
    field :username, :string
    field :hash, :string
    field :firstname, :string
    field :lastname, :string
    field :patronymic, :string
    field :gender, :string
    field :city, :string
    field :about, :string
    field :birthdate, :string

    has_one :avatar, Backend.User.Avatar
    has_many :posts, Backend.User.Post
  end

  # def changeset(user, params \\ %{}) do
  #   user
  #     |> Changeset.cast(params, [:email, :name, :password, :age])
  #     |> Changeset.validate_required([:name, :password])
  #     |> Changeset.validate_length(:name, min: 3)
  # end

  def get_first_record do
    Backend.Repo.one(Ecto.Query.from u in __MODULE__, order_by: [asc: u.id], limit: 1)
  end

  def get_last_record do
    __MODULE__
      |> Ecto.Query.last()
      |> Backend.Repo.one()
  end

end
