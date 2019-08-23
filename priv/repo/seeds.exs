# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Shop.Repo.insert!(%Shop.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
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
    Repo.delete_all(User.Friend)
    Repo.delete_all(User.Photo)
    Repo.delete_all(User.Post)
    Repo.delete_all(User.Ignore)
    Repo.delete_all(User)
  end

  defp clear_chats do
    Repo.delete_all(Chat.ChatInvite)
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

    starkPhotos = [
      %User.Photo{
        title: "Hungry insect in the city, call the police",
        url: "/image/gallery/me_0.jpg"
      },
      %User.Photo{title: "Istambul <3", url: "/image/gallery/me_1.jpg"},
      %User.Photo{title: "Hi-tech undewear", url: "/image/gallery/me_2.jpg"},
      %User.Photo{title: "Ironman plays with ironman", url: "/image/gallery/me_3.jpg"},
      %User.Photo{title: "Look at my red glasses", url: "/image/gallery/me_4.jpg"},
      %User.Photo{title: "Peace (=", url: "/image/gallery/me_5.jpg"},
      %User.Photo{title: "Sup?", url: "/image/gallery/me_6.jpg"},
      %User.Photo{title: "Who is stronger?!", url: "/image/gallery/me_07.jpg"},
      %User.Photo{title: "Chilling after Tanos ...", url: "/image/gallery/me_08.jpg"},
      %User.Photo{
        title: "Do you know how is this ...man?!",
        url: "/image/gallery/me_09.jpg"
      },
      %User.Photo{title: "Look at my big cigar", url: "/image/gallery/me_10.jpg"},
      %User.Photo{title: "The world is on fire", url: "/image/gallery/me_11.jpg"}
    ]

    batman =
      Jason.decode!(
        ~s({"username":"batman@gothem.com","firstname":"Bruce","lastname":"Wayne","city":"Gotham","about":"This city needs a new hero","gender":"male"})
      )
      |> Map.new(&keyToAtom/1)
      |> Map.put(:avatar, %User.Photo{title: "avatar", url: "/image/avatar/batman.jpg"})
      |> Map.put(:birthdate, ~D[1970-01-01])

    stark =
      Jason.decode!(
        ~s({"username":"Tony@stark.com","firstname":"Tony","lastname":"Stark","city":"New-York","gender":"male","patronymic":"Ironman","avatar":"/image/avatar/me.jpg","about":"Genius, Billionaire, Playboy, Philanthropist"})
      )
      |> Map.new(&keyToAtom/1)
      |> Map.put(:avatar, %User.Photo{title: "avatar", url: "/image/avatar/me.jpg"})
      |> Map.put(:birthdate, ~D[1963-02-22])
      |> Map.put(:statistic, %{posts: 13, likes: 68})
      |> Map.put(:photos, starkPhotos)

    batman =
      %User{}
      |> Map.merge(batman)
      |> Repo.insert!()

    stark =
      %User{}
      |> Map.merge(stark)
      |> Repo.insert!()

    %User.Friend{user1: stark.id}
    |> Map.put(:user2, batman.id)
    |> Repo.insert!()

    %User.Ignore{user: stark.id}
    |> Map.put(:user_ignore, batman.id)
    |> Repo.insert!()
  end

  defp init_chats do
    IO.puts("Loading chats...")

    stark =
      Query.from(u in User, where: u.username == "Tony@stark.com")
      |> Repo.one()

    # groupChat1 =
    #   %Backend.Chat{
    #     name: "How to defeat Thanos?",
    #     image: "/image/chat/group1.jpg",
    #     owner_id: stark.id,
    #     members: [stark.id]
    #   }
    #   |> Repo.insert!()
    {:ok, groupChat1} =
      %Chat{}
      |> Chat.changeset(%{
        name: "How to defeat Thanos?",
        image: "/image/chat/group1.jpg",
        owner_id: stark.id,
        members: [stark.id]
      })
      |> Repo.insert!()

    # IO.inspect(groupChat1)
  end

  defp keyToAtom({key, value}) do
    {String.to_atom(key), value}
  end
end

Backend.Data.generate()
