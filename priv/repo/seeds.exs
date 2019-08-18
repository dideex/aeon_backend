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
  alias Backend.{Repo, User, Chat}

  def generate() do
    clear_db()
    populate()
  end

  defp clear_db do
    IO.puts("Clearing db...")
    Repo.delete_all(User.Notification)
    Repo.delete_all(User.Friend)
    Repo.delete_all(User.Photo)
    Repo.delete_all(User.Post)
    Repo.delete_all(User)
    Repo.delete_all(Chat.ChatInvite)
    Repo.delete_all(Chat.Message)
    Repo.delete_all(Chat)
    IO.puts("DB has been clear!")
  end

  defp populate do
    IO.puts("Inserting data into db...")
    init_users()
    IO.puts("Data has been insert into!")
  end

  defp init_users do
    # %Backend.User{}
    #   |> Map.Merge(stark)
    #   |> Backend.Repo.insert!
    starkPhotos = [
      %Backend.User.Photo{
        title: "Hungry insect in the city, call the police",
        url: "/image/gallery/me_0.jpg"
      },
      %Backend.User.Photo{title: "Istambul <3", url: "/image/gallery/me_1.jpg"},
      %Backend.User.Photo{title: "Hi-tech undewear", url: "/image/gallery/me_2.jpg"},
      %Backend.User.Photo{title: "Ironman plays with ironman", url: "/image/gallery/me_3.jpg"},
      %Backend.User.Photo{title: "Look at my red glasses", url: "/image/gallery/me_4.jpg"},
      %Backend.User.Photo{title: "Peace (=", url: "/image/gallery/me_5.jpg"},
      %Backend.User.Photo{title: "Sup?", url: "/image/gallery/me_6.jpg"},
      %Backend.User.Photo{title: "Who is stronger?!", url: "/image/gallery/me_07.jpg"},
      %Backend.User.Photo{title: "Chilling after Tanos ...", url: "/image/gallery/me_08.jpg"},
      %Backend.User.Photo{
        title: "Do you know how is this ...man?!",
        url: "/image/gallery/me_09.jpg"
      },
      %Backend.User.Photo{title: "Look at my big cigar", url: "/image/gallery/me_10.jpg"},
      %Backend.User.Photo{title: "The world is on fire", url: "/image/gallery/me_11.jpg"}
    ]

    batman =
      Jason.decode!(
        ~s({"username":"batman@gothem.com","firstname":"Bruce","lastname":"Wayne","city":"Gotham","about":"This city needs a new hero","gender":"male"})
      )
      |> Map.new(&keyToAtom/1)
      |> Map.put(:avatar, %Backend.User.Photo{title: "avatar", url: "/image/avatar/batman.jpg"})
      |> Map.put(:birthdate, ~D[1970-01-01])

    stark =
      Jason.decode!(
        ~s({"username":"Tony@stark.com","firstname":"Tony","lastname":"Stark","city":"New-York","gender":"male","patronymic":"Ironman","avatar":"/image/avatar/me.jpg","about":"Genius, Billionaire, Playboy, Philanthropist"})
      )
      |> Map.new(&keyToAtom/1)
      |> Map.put(:avatar, %Backend.User.Photo{title: "avatar", url: "/image/avatar/me.jpg"})
      |> Map.put(:birthdate, ~D[1963-02-22])
      |> Map.put(:statistic, %{posts: 13, likes: 68})
      |> Map.put(:photos, starkPhotos)

    batman = %Backend.User{}
    |> Map.merge(batman)
    |> Backend.Repo.insert!()

    stark = %Backend.User{}
    |> Map.merge(stark)
    |> Backend.Repo.insert!()

    %Backend.User.Friend{user1: stark.id}
    |> Map.put(:user2, batman.id)
    |> Backend.Repo.insert!()

    %Backend.User.Ignore{user: stark.id}
    |> Map.put(:user_ignore, batman.id)
    |> Backend.Repo.insert!()

  end

  defp keyToAtom({key, value}) do
    {String.to_atom(key), value}
  end
end

Backend.Data.generate()
