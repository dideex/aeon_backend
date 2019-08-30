defmodule Backend.Data do
  require Ecto.Query
  alias Backend.{Repo, User, Chat}
  # alias Ecto.Query

  def generate() do
    clear_db()
    populate()
  end

  defp clear_db do
    IO.puts("Clearing db..")
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
    IO.puts("Inserting data into db..")

    users = init_users()
    chats = init_chats(users)

    users
    |> init_avatars
    |> init_photos
    |> init_friends
    |> init_posts
    |> init_notifications
    |> init_messages(chats)

    IO.puts("Data has been insert!")
  end

  defp init_users do
    IO.puts("Loading users..")

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
       ~s({"username":"ediebrook@azghard.com","firstname":"Eddy","lastname":"Brock","city":"New-York","about":"Eyes, lungs, stomach, and would have eaten, but once","gender":"male" }),
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

  defp init_avatars(users) do
    IO.puts("Inserting avatars..")

    avatarModels = [
      {:stark, %{title: "stark avatar", url: "/image/avatar/me.jpg"}},
      {:spiderman, %{title: "spiderman avatar", url: "/image/avatar/spiderman.jpg"}},
      {:superman, %{title: "superman avatar", url: "/image/avatar/superman.jpg"}},
      {:wolverine, %{title: "wolverine avatar", url: "/image/avatar/wolverine.jpg"}},
      {:captainAmerica, %{title: "America avatar", url: "/image/avatar/captainAmerica.jpg"}},
      {:thor, %{title: "thor avatar", url: "/image/avatar/thor.jpg"}},
      {:venom, %{title: "venom avatar", url: "/image/avatar/venom.jpg"}},
      {:blackWidow, %{title: "blackWidow avatar", url: "/image/avatar/blackWidow.jpg"}},
      {:ant, %{title: "ant avatar", url: "/image/avatar/ant.jpg"}},
      {:marvel, %{title: "marvel avatar", url: "/image/avatar/marvel.jpg"}},
      {:blackPanther, %{title: "blackPanther avatar", url: "/image/avatar/blackPanther.jpg"}},
      {:strange, %{title: "strange avatar", url: "/image/avatar/strange.jpg"}},
      {:hulk, %{title: "hulk avatar", url: "/image/avatar/hulk.jpg"}},
      {:daredevil, %{title: "daredevil avatar", url: "/image/avatar/daredevil.jpg"}},
      {:deadpool, %{title: "deadpool avatar", url: "/image/avatar/deadpool.jpg"}},
      {:quill, %{title: "quill avatar", url: "/image/avatar/quill.jpg"}},
      {:gamora, %{title: "gamora avatar", url: "/image/avatar/gamora.jpg"}},
      {:drax, %{title: "drax avatar", url: "/image/avatar/drax.jpg"}},
      {:pepper, %{title: "pepper avatar", url: "/image/avatar/pepper.jpg"}}
    ]

    avatarModels
    |> Enum.each(fn {name, avatarModel} ->
      Ecto.build_assoc(users[name], :avatar, avatarModel)
      |> Repo.insert()
    end)

    users
  end

  defp init_photos(users) do
    IO.puts("Inserting photos..")

    # [{PhotoModel: %Photo{}, likes: [User]}]
    starkPhotos = [
      {%User.Photo{
         title: "Hungry insect in the city, call the police",
         url: "/image/gallery/me_0.jpg"
       }, [users.spiderman, users.batman, users.superman]},
      {%User.Photo{title: "Istambul <3", url: "/image/gallery/me_1.jpg"},
       [users.batman, users.superman, users.blackWidow, users.daredevil, users.marvel]},
      {%User.Photo{title: "Hi-tech undewear", url: "/image/gallery/me_2.jpg"},
       [users.superman, users.blackWidow, users.venom, users.thor]},
      {%User.Photo{title: "Ironman plays with ironman", url: "/image/gallery/me_3.jpg"},
       [users.batman, users.daredevil, users.deadpool]},
      {%User.Photo{title: "Look at my red glasses", url: "/image/gallery/me_4.jpg"}, [users.ant]},
      {%User.Photo{title: "Peace (=", url: "/image/gallery/me_5.jpg"},
       [users.superman, users.deadpool, users.hulk, users.thor]},
      {%User.Photo{title: "Sup?", url: "/image/gallery/me_6.jpg"},
       [users.batman, users.superman, users.blackPanther, users.wolverine]},
      {%User.Photo{title: "Who is stronger?!", url: "/image/gallery/me_07.jpg"},
       [users.batman, users.deadpool, users.venom]},
      {%User.Photo{title: "Chilling after Tanos ..", url: "/image/gallery/me_08.jpg"},
       [
         users.batman,
         users.hulk,
         users.blackPanther,
         users.blackWidow,
         users.captainAmerica,
         users.daredevil,
         users.strange,
         users.venom
       ]},
      {%User.Photo{title: "Do you know how is this ...man?!", url: "/image/gallery/me_09.jpg"},
       [users.spiderman, users.captainAmerica]},
      {%User.Photo{title: "Look at my big cigar", url: "/image/gallery/me_10.jpg"},
       [users.batman, users.spiderman, users.superman]},
      {%User.Photo{title: "The world is on fire", url: "/image/gallery/me_11.jpg"}, []}
    ]

    # Add stark photos
    starkPhotos
    |> Enum.map(fn {photoModel, likes} ->
      photoModel = Repo.preload(photoModel, :likes)

      Ecto.build_assoc(users.stark, :photos, photoModel)
      |> Repo.insert!()
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:likes, likes)
      |> Repo.update!()
    end)

    users
  end

  defp init_friends(%{stark: stark, quill: quill} = users) do
    IO.puts("Associating friend relationships..")

    Enum.each(users, fn
      {_, user} ->
        cond do
          stark.id !== user.id and quill.id !== user.id ->
            Ecto.build_assoc(stark, :friends, %User.Friend{friend_id: user.id})
            |> Repo.insert!()

            Ecto.build_assoc(user, :friends, %User.Friend{friend_id: stark.id})
            |> Repo.insert!()

          true ->
            nil
        end
    end)

    %User.FriendInvite{}
    |> User.FriendInvite.changeset(%{user_id: stark.id, sender_id: quill.id})
    |> Repo.insert!()

    %User.MuteUser{}
    |> User.MuteUser.changeset(%{user_id: stark.id, mute_user_id: quill.id})
    |> Repo.insert!()

    users
  end

  defp init_chats(%{stark: stark} = users) do
    IO.puts("Loading chats..")

    chatModels = [
      {:group1,
       ~s({"name":"How to defeat Thanos?","image":"/image/chat/group1.jpg","group":true}),
       [stark, users.quill, users.drax, users.spiderman, users.strange, users.gamora], stark.id},
      {:group2, ~s({"name":"Where is gamora??","image":"/image/chat/group2.jpg","group":true}),
       [stark, users.quill, users.drax], users.quill.id},
      {:pm1, ~s({"group":false}), [stark, users.pepper], stark.id},
      {:pm2, ~s({"group":false}), [stark, users.blackWidow], stark.id},
      {:pm3, ~s({"group":false}), [stark, users.quill], stark.id},
      {:pm4, ~s({"group":false}), [stark, users.spiderman], stark.id},
      {:pm5, ~s({"group":false}), [stark, users.hulk], stark.id},
      {:pm6, ~s({"group":false}), [stark, users.strange], stark.id}
    ]

    Enum.reduce(chatModels, %{}, fn {name, model, members, owner_id}, acc ->
      preparedModel =
        Jason.decode!(model)
        |> Map.new(&keyToAtom/1)
        |> Map.put(:owner_id, owner_id)

      user =
        %Chat{}
        |> Repo.preload(:members)
        |> Chat.changeset(preparedModel)
        |> Repo.insert!()
        |> Ecto.Changeset.change()
        |> Ecto.Changeset.put_assoc(:members, members)
        |> Repo.update!()

      Map.put(acc, name, user)
    end)
  end

  defp init_messages(%{stark: stark} = users, chats) do
    IO.puts("Loading chat invites..")

    %Chat.Invite{}
    |> Chat.Invite.changeset(%{
      user_id: stark.id,
      sender_id: users.batman.id,
      chat_id: chats.group1.id
    })
    |> Repo.insert!()

    IO.puts("Loading chat messages..")

    messages = [
      {"What the hell happened to this planet?", users.quill.id, chats.group1.id},
      {"It's 8 degrees off its axis", users.quill.id, chats.group1.id},
      {"Gravitational pull is all over the place", users.quill.id, chats.group1.id},
      {"Yeah, we got one advantage. He's coming to us", stark.id, chats.group1.id},
      {"We'll use it. Alright, I have a plan", stark.id, chats.group1.id},
      {"It's pretty simple. We draw him in, pin him down, get what we need", stark.id,
       chats.group1.id},
      {"We definitely don't want to dance with this guy, we just want the gauntlet", stark.id,
       chats.group1.id},
      {"Are you yawning?", stark.id, chats.group1.id},
      {"In the middle of this, while I'm breaking it down?", stark.id, chats.group1.id},
      {"Did you hear what I said?", stark.id, chats.group1.id},
      {"I stopped listening after you said that we need a plan", users.drax.id, chats.group1.id},
      {"Okay, Mr. Clean's on his own page", stark.id, chats.group1.id},
      {"See, not winging it isn't really what they do", users.quill.id, chats.group1.id},
      {"What exactly is it that they do?", users.spiderman.id, chats.group1.id},
      {"Kick names, take ass", users.gamora.id, chats.group1.id},
      {"All right, just get over here, please?", stark.id, chats.group1.id},
      {"Mr. Lord, can you get your folks to circle up?", stark.id, chats.group1.id},
      {"Star-Lord is fine", users.quill.id, chats.group1.id},
      {"We've gotta coalesce", stark.id, chats.group1.id},
      {"Because if all we come at him with is a plucky attitude..", stark.id, chats.group1.id},
      {"Dude, don't call us plucky. We don't know what it means", users.quill.id,
       chats.group1.id},
      {"All right, we're optimistic, yes. I like your plan, except it sucks", users.quill.id,
       chats.group1.id},
      {"So let me do the plan, and that way, it might be really good", users.quill.id,
       chats.group1.id},
      {"All right, we're optimistic, yes. I like your plan, except it sucks", users.quill.id,
       chats.group1.id},
      {"So let me do the plan, and that way, it might be really good", users.quill.id,
       chats.group1.id},
      {"Tell him about the dance-off to save the Universe", users.drax.id, chats.group1.id},
      {"What dance-off?", stark.id, chats.group1.id},
      {"It's not a, it's not a..", users.quill.id, chats.group1.id},
      {"Like in Footloose? The movie?", users.spiderman.id, chats.group1.id},
      {"Exactly like Footloose! Is it still the greatest movie in history?", users.quill.id,
       chats.group1.id},
      {"It never was", users.spiderman.id, chats.group1.id},
      {"We're getting no help with Flash Gordon", stark.id, chats.group1.id},
      {"Flash Gordon?", users.quill.id, chats.group1.id},
      {"By the way? That's a compliment. Don't forget", users.quill.id, chats.group1.id},
      {"I'm half-human. So that's 50% of me that's stupid", users.quill.id, chats.group1.id},
      {"And that's 100% you", users.quill.id, chats.group1.id},
      {"Your math is blowing my mind", stark.id, chats.group1.id},
      {"Excuse me?", users.gamora.id, chats.group1.id},
      {"But does your friend often do that?", users.gamora.id, chats.group1.id},
      {"Strange! You all right?", stark.id, chats.group1.id},
      {"You're back. You're all right", stark.id, chats.group1.id},
      {"Hey, what was that?", users.spiderman.id, chats.group1.id},
      {"I went forward in time, to view alternate futures..", users.strange.id, chats.group1.id},
      {"To see all the possible outcomes of the coming conflict", users.strange.id,
       chats.group1.id},
      {"How many did you see? ", users.quill.id, chats.group1.id},
      {"14,000,605", users.strange.id, chats.group1.id},
      {"How many did we win?", stark.id, chats.group1.id},
      {"One", users.strange.id, chats.group1.id},
      # Group2
      {"I'm gonna ask you this one time", users.quill.id, chats.group2.id},
      {"Where is Gamora?", users.quill.id, chats.group2.id},
      {"Yeah, I'll do you one better", stark.id, chats.group2.id},
      {"Who is Gamora", stark.id, chats.group2.id},
      {"I'll do you one better", users.drax.id, chats.group2.id},
      {"Why is Gamora", users.drax.id, chats.group2.id},
      # pm1
      {"What, you got plans?", stark.id, chats.pm1.id},
      {"What, you got plans?", users.pepper.id, chats.pm1.id},
      {"I don't like it when you have plans", stark.id, chats.pm1.id},
      {"I'm allowed to have plans on my birthday", users.pepper.id, chats.pm1.id},
      {"It's your birthday?", stark.id, chats.pm1.id},
      {"Yes", users.pepper.id, chats.pm1.id},
      {"I knew that. Already?", stark.id, chats.pm1.id},
      {"Yeah, isn't that strange? It's the same day as last year", users.pepper.id, chats.pm1.id},
      {"Get yourself something nice from me", stark.id, chats.pm1.id},
      {"I already did", users.pepper.id, chats.pm1.id},
      {"Yeah? And?", stark.id, chats.pm1.id},
      {"Oh, it's very nice... very tasteful. Thank you, Mr. Stark", users.pepper.id,
       chats.pm1.id},
      {"You're welcome, Ms. Potts", stark.id, chats.pm1.id},
      # pm2
      {"I'm surprised you could keep your mouth shut", users.blackWidow.id, chats.pm2.id},
      {"You're good. You are mind-blowingly duplicitous. How do you do it? You're a triple impostor, I've never seen anything like it. Is there anything real about you? Do you even speak Latin?",
       stark.id, chats.pm2.id},
      {"Fallaces sunt rerum species", users.blackWidow.id, chats.pm2.id},
      {"Which means? Wait, what did you just say?", stark.id, chats.pm2.id},
      {"It means you can either drive yourself home or I can have you collected",
       users.blackWidow.id, chats.pm2.id},
      # pm3
      {"You're from Earth?", stark.id, chats.pm3.id},
      {"I'm not from Earth, I'm from Missouri", users.quill.id, chats.pm3.id},
      {"Yeah, that's on Earth, dipshit!", stark.id, chats.pm3.id},
      # pm4
      {"You just don't do anything I would do... and definitely don't do anything I wouldn't do. There's a little gray area in there and that's where you operate",
       stark.id, chats.pm4.id},
      {"Wait, does that mean that I'm an Avenger?", users.spiderman.id, chats.pm4.id},
      {"No", stark.id, chats.pm4.id},
      # pm5
      {"The Avengers broke up. We're toast", stark.id, chats.pm5.id},
      {"Broke up? Like a band? Like the Beatles?", users.hulk.id, chats.pm5.id},
      # pm6
      {"He has the Power and Space stones, that already makes him the strongest creature in the whole universe. If he gets his hands on all six stones, Tony..",
       users.strange.id, chats.pm6.id},
      {"He could destroy life on a scale hitherto undreamt of", users.strange.id, chats.pm6.id},
      {"Did you seriously just say 'hitherto undreamt of?", stark.id, chats.pm6.id},
      {"Are you seriously leaning on the Cauldron of the Cosmos?", users.strange.id, chats.pm6.id}
    ]

    Enum.each(messages, fn {body, sender_id, chat_id} ->
      unread_message =
        %Chat.Message{
          body: body,
          sender_id: sender_id,
          chat_id: chat_id
        }
        |> Repo.preload(:unread)

      Ecto.build_assoc(stark, :unread_messages, unread_message)
      |> Repo.insert!()
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:unread, [stark])
      |> Repo.update!()
    end)

    users
  end

  defp init_posts(users) do
    IO.puts("Loading posts..")

    %User.Post{}
    |> User.Post.changeset(%{
      title: "The 'We Love You 3000' Tour Hits Chicago, Miami, Los Angeles, and Minneapolis",
      body:
        "The wait is over to bring home the biggest movie of all time! Marvel Studios' Avengers: Endgame is now available on Digital and Blu-ray, as of this week",
      photo: "/image/post/post1.jpg",
      views: 10,
      author_id: users.stark.id
    })
    |> Repo.insert!()
    |> Repo.preload(:likes)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:likes, [users.batman, users.stark])
    |> Repo.update!()

    users
  end

  defp init_notifications(users) do
    IO.puts("Loading notifications..")
    # ...
    users
  end

  defp keyToAtom({key, value}) do
    {String.to_atom(key), value}
  end
end

Backend.Data.generate()
