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
    Repo.delete_all(User.Friend)
    # Repo.delete_all(User.Friend)
    Repo.delete_all(User.PhotoLike)
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

    starkModel =
      Jason.decode!(
        ~s({"username":"Tony@stark.com","firstname":"Tony","lastname":"Stark","city":"New-York","gender":"male","patronymic":"Ironman","avatar":"/image/avatar/me.jpg","about":"Genius, Billionaire, Playboy, Philanthropist"})
      )
      |> Map.new(&keyToAtom/1)
      |> Map.put(:birthdate, ~D[1963-02-22])
      |> Map.put(:password, "qwerqwer")
      |> Map.put(:statistic, %{posts: 13, likes: 68})

    stark =
      %User{}
      |> User.changeset(starkModel)
      |> Repo.insert!()

    Ecto.build_assoc(stark, :avatar, %User.Avatar{
      title: "My photo",
      url: "/image/avatar/me.jpg"
    })
    |> Repo.insert()

    # [{PhotoModel: %Photo{}, likes: [User]}]
    starkPhotos = [
      {%User.Photo{
         title: "Hungry insect in the city, call the police",
         url: "/image/gallery/me_0.jpg"
       }, [stark, batman]},
      {%User.Photo{title: "Istambul <3", url: "/image/gallery/me_1.jpg"}, [stark, batman]},
      {%User.Photo{title: "Hi-tech undewear", url: "/image/gallery/me_2.jpg"}, [stark, batman]},
      {%User.Photo{title: "Ironman plays with ironman", url: "/image/gallery/me_3.jpg"},
       [stark, batman]},
      {%User.Photo{title: "Look at my red glasses", url: "/image/gallery/me_4.jpg"},
       [stark, batman]},
      {%User.Photo{title: "Peace (=", url: "/image/gallery/me_5.jpg"}, [stark, batman]},
      {%User.Photo{title: "Sup?", url: "/image/gallery/me_6.jpg"}, [stark, batman]},
      {%User.Photo{title: "Who is stronger?!", url: "/image/gallery/me_07.jpg"}, [stark, batman]},
      {%User.Photo{title: "Chilling after Tanos ...", url: "/image/gallery/me_08.jpg"},
       [stark, batman]},
      {%User.Photo{title: "Do you know how is this ...man?!", url: "/image/gallery/me_09.jpg"},
       [stark, batman]},
      {%User.Photo{title: "Look at my big cigar", url: "/image/gallery/me_10.jpg"},
       [stark, batman]},
      {%User.Photo{title: "The world is on fire", url: "/image/gallery/me_11.jpg"},
       [stark, batman]}
    ]

    # Add stark photos
    starkPhotos
    |> Enum.map(fn {photoModel, likes} ->
      photoModel = Repo.preload(photoModel, :likes)

      Ecto.build_assoc(stark, :photos, photoModel)
      |> Repo.insert!()
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:likes, likes)
      |> Repo.update!()
    end)

    Ecto.build_assoc(batman, :avatar, %User.Avatar{
      title: "avatar",
      url: "/image/avatar/batman.jpg"
    })
    |> Repo.insert()

    stark
    |> Repo.preload(:friends)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:friends, [batman])
    |> Repo.update!()
  end

  defp init_chats do
    IO.puts("Loading chats...")
  end

  defp keyToAtom({key, value}) do
    {String.to_atom(key), value}
  end
end

Backend.Data.generate()
