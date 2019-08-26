defmodule Backend.Data do
  require Ecto.Query
  alias Backend.{Repo, User, Chat}
  alias Ecto.Query

  def generate() do
    clear_db()
    populate()
  end

  defp clear_db do
    IO.puts("Clearing db...")
    clear_chats()
    clear_users()
    IO.puts("DB has been clear!")
  end

  defp clear_users do
    Repo.delete_all(User.Notification)
    Repo.delete_all(User.FriendInvite)
    # Repo.delete_all(User.Friend)
    Repo.delete_all(User.Photo)
    Repo.delete_all(User.Post)
    # Repo.delete_all(User.Ignore)
    Repo.delete_all(User.Avatar)
    Repo.delete_all(User)
  end

  defp clear_chats do
    Repo.delete_all(Chat.Invite)
    Repo.delete_all(Chat.Message)
    Repo.delete_all(Chat)
  end

  defp populate do
    IO.puts("Inserting data into db...")
    init_users()
    init_chats()
    IO.puts("Data has been insert!")
  end

  defp init_users do
    IO.puts("Loading users...")

    batmanModel =
      Jason.decode!(
        ~s({"username":"batman@gothem.com","firstname":"Bruce","lastname":"Wayne","city":"Gotham","about":"This city needs a new hero","gender":"male"})
      )
      |> Map.new(&keyToAtom/1)
      |> Map.put(:birthdate, ~D[1970-01-01])
      |> Map.put(:password, "qwerqwer")

    batman =
      %User{}
      |> User.changeset(batmanModel)
      |> Repo.insert!()

    Ecto.build_assoc(batman, :avatar, %User.Avatar{
      title: "avatar",
      url: "/image/avatar/batman.jpg"
    })
    |> Repo.insert()
  end

  defp init_chats do
    IO.puts("Loading chats...")
  end

  defp keyToAtom({key, value}) do
    {String.to_atom(key), value}
  end
end

Backend.Data.generate()
