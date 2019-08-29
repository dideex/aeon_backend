defmodule Backend.Data do
  require Ecto.Query
  alias Backend.{Repo, User, Chat}
  # alias Ecto.Query

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
    Repo.delete_all(User.PhotoLike)
    Repo.delete_all(User.PostLike)
    Repo.delete_all(User.Notification)
    Repo.delete_all(User.FriendInvite)
    Repo.delete_all(User.Friend)
    Repo.delete_all(User.MuteUser)
    Repo.delete_all(User.Photo)
    Repo.delete_all(User.Post)
    Repo.delete_all(User.Avatar)
    Repo.delete_all(User)
  end

  defp clear_chats do
    Repo.delete_all(Chat.Unread)
    Repo.delete_all(Chat.Member)
    Repo.delete_all(Chat.Invite)
    Repo.delete_all(Chat.Message)
    Repo.delete_all(Chat)
  end

  defp populate do
    IO.puts("Inserting data into db...")

    users = init_users()

    init_photos(users)
    init_friends(users)

    chats = init_chats(users)
    init_messages(users, chats)

    init_posts(users)
    init_notifications(users)

    IO.puts("Data has been insert!")
  end

  defp init_users do
    IO.puts("Loading users...")

    userModels = [
      {:stark,
       ~s({"username":"Tony@stark.com","firstname":"Tony","lastname":"Stark","city":"New-York","gender":"male","patronymic":"Ironman","about":"Genius, Billionaire, Playboy, Philanthropist"}),
       ~D[1980-08-01]},
      {:batman,
       ~s({"username":"batman@gothem.com","firstname":"Bruce","lastname":"Wayne","city":"Gotham","about":"This city needs a new hero","gender":"male"}),
       ~D[1992-11-21]},
      {:spiderman,
       ~s({"username":"pspidy@nyc.com","firstname":"Peter","lastname":"Parker","city":"New-York","about":"With great power comes great responsibility","gender":"male" }),
       ~D[1970-03-03]},
      {:superman,
       ~s({"username":"superman@nyc.com","firstname":"Clark","lastname":"Kent","city":"New-York","about":"My sin? - salvation of the world","gender":"male" }),
       ~D[1987-04-01]},
      {:wolverine,
       ~s({"username":"wolverine@rats.com","firstname":"James","lastname":"Howlett","patronymic":"Logan","city":"Ottawa","about":"Want to take your brains out? You are welcome. Not here. I washed the floors here","gender":"male" }),
       ~D[1991-05-21]},
      {:captainAmerica,
       ~s({"username":"captain@usa.com","firstname":"Steve","lastname":"Rogers","city":"Brooklyn","about":"When patriots become heroes","gender":"male" }),
       ~D[1983-06-11]},
      {:thor,
       ~s({"username":"tor@azghard.com","firstname":"Thor","lastname":"Odison","city":"Asghard","about":"For every minute, the future is becoming the past","gender":"male" }),
       ~D[1986-07-21]},
      {:venom,
       ~s({"username":"ediebrook@azghard.com","firstname":"Eddy","lastname":"Brock","city":"New-York","about":"Eyes, lungs, stomach, and would have eaten, but once.","gender":"male" }),
       ~D[1987-08-13]},
      {:blackWidow,
       ~s({"username":"bwidnow@mail.ru","firstname":"Natalya","lastname":"Romanova","patronymic":"Ivanova","city":"Stalingrad","gender":"female" }),
       ~D[1990-09-20]},
      {:ant,
       ~s({"username":"slang@gmail.com","firstname":"Scott","lastname":"Lang","city":"Florida","about":"Scott, you are an animal! No, I'm an insect!","gender":"male" }),
       ~D[1977-10-10]},
      {:marvel,
       ~s({"username":"carol@marvel.com","firstname":"Carol","lastname":"Danvers","city":"Halu","about":"You know nothing about me","gender":"female" }),
       ~D[1989-11-11]},
      {:blackPanther,
       ~s({"username":"king@vakanda.com","firstname":"T'","lastname":"Challa","city":"Vakanda","about":"Vakanda forever","gender":"male" }),
       ~D[1987-12-21]},
      {:strange,
       ~s({"username":"drstrange@avengers.com","firstname":"Vincent","lastname":"Strange","city":"Philadelphy","about":"Beyond the brink of consciousness lies a new reality","gender":"male" }),
       ~D[1992-01-31]},
      {:hulk,
       ~s({"username":"bigboy@nyc.com","firstname":"Robert","lastname":"Bruce","patronymic":"Banner","city":"New-York","about":"It's about time to added a little bit of anger","gender":"male" }),
       ~D[1990-02-21]},
      {:daredevil,
       ~s({"username":"mardok@mail.com","firstname":"Matthew","lastname":"Murdock","patronymic":"Michael","city":"New-York","about":"The man without fear","gender":"male" }),
       ~D[1976-04-18]},
      {:deadpool,
       ~s({"username":"asshole@nyc.com","firstname":"Wade","lastname":"Winston","patronymic":"Wilson","city":"New-York","about":"With great power comes great irresponsibility","gender":"male" }),
       ~D[1975-05-08]},
      {:quill,
       ~s({"username":"quill@galaxy.com","firstname":"Peter","lastname":"Quill","patronymic":"Jason","city":"New-York","about":"Star-Lord","gender":"male" }),
       ~D[1979-10-02]},
      {:gamora,
       ~s({"username":"gamora@tanos.com","firstname":"Gamora","lastname":"Long","city":"Kronos","about":"The Most Dangerous Woman in the Universe","gender":"female" }),
       ~D[1999-03-30]},
      {:drax,
       ~s({"username":"chak@galaxy.com","firstname":"Arthur","lastname":"Sampson","patronymic":"Douglas","city":"Kronos","about":"Drax the Destroyer","gender":"male" }),
       ~D[1989-11-21]},
      {:pepper,
       ~s({"username":"peper@stark.net","firstname":"Virginia","lastname":"Potts","patronymic":"Pepper","city":"New-York","gender":"female" }),
       ~D[1978-06-11]}
    ]

    Enum.reduce(userModels, %{}, fn {name, model, birthdate}, acc ->
      preparedModel =
        Jason.decode!(model)
        |> Map.new(&keyToAtom/1)
        |> Map.put(:birthdate, birthdate)
        |> Map.put(:password, "qwerqwer")

      user =
        %User{}
        |> User.changeset(preparedModel)
        |> Repo.insert!()

      Map.put(acc, name, user)
    end)
  end

  defp init_photos(%{stark: stark, batman: batman}) do
    IO.puts("Inserting photos...")

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
  end

  defp init_friends(%{stark: stark, batman: batman}) do
    IO.puts("Associating friend relationships...")

    Ecto.build_assoc(stark, :friends, %User.Friend{friend_id: batman.id})
    |> Repo.insert!()

    Ecto.build_assoc(batman, :friends, %User.Friend{friend_id: stark.id})
    |> Repo.insert!()

    %User.FriendInvite{}
    |> User.FriendInvite.changeset(%{user_id: stark.id, sender_id: batman.id})
    |> Repo.insert!()

    %User.MuteUser{}
    |> User.MuteUser.changeset(%{user_id: stark.id, mute_user_id: batman.id})
    |> Repo.insert!()
  end

  defp init_chats(%{stark: stark, batman: batman}) do
    IO.puts("Loading chats...")

    chat1_modle =
      chat1 =
      %Chat{
        name: "How to defeat Thanos?",
        image: "/image/chat/group1.jpg"
      }
      |> Repo.preload(:members)

    Ecto.build_assoc(stark, :chat_owner, chat1_modle)
    |> Repo.insert!()
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:members, [batman, stark])
    |> Repo.update!()

    IO.puts("Loading chat invites...")

    %Chat.Invite{}
    |> Chat.Invite.changeset(%{user_id: stark.id, sender_id: batman.id, chat_id: chat1.id})
    |> Repo.insert!()

    %{chat1: chat1}
  end

  defp init_messages(%{stark: stark, batman: batman} = users, %{chat1: chat1}) do
    IO.puts("Loading chat messages...")

    unread_message1 =
      %Chat.Message{
        body: "Yeah, we got one advantage. He's coming to us",
        sender_id: stark.id,
        chat_id: chat1.id
      }
      |> Repo.preload(:unread)

    Ecto.build_assoc(stark, :unread_messages, unread_message1)
    |> Repo.insert!()
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:unread, [batman])
    |> Repo.update!()
  end

  defp init_posts(users) do
    IO.puts("Loading posts...")

    %User.Post{}
    |> User.Post.changeset(%{
      title: "The 'We Love You 3000' Tour Hits Chicago, Miami, Los Angeles, and Minneapolis",
      body:
        "The wait is over to bring home the biggest movie of all time! Marvel Studios' Avengers: Endgame is now available on Digital and Blu-ray, as of this week.",
      photo: "/image/post/post1.jpg",
      views: 10,
      author_id: users.stark.id
    })
    |> Repo.insert!()
    |> Repo.preload(:likes)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:likes, [users.batman, users.stark])
    |> Repo.update!()
  end

  defp init_notifications(%{stark: stark, batman: batman}) do
    IO.puts("Loading notifications...")
    # ...
  end

  defp keyToAtom({key, value}) do
    {String.to_atom(key), value}
  end
end

Backend.Data.generate()
