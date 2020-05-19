defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :guest do
    plug(:accepts, ["json"])
    # plug(CORSPlug, origin: "*")
  end

  pipeline :user do
    plug(:accepts, ["json"])
    # plug(CORSPlug, origin: "*")
    plug(Backend.Plugs.Context)
  end

  scope "/" do
    pipe_through(:guest)

    forward(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: Backend.Schema.Guest,
      interface: :playground,
      socket_url: "http://localhost:4000/guest"
    )
  end

  scope "/user" do
    pipe_through(:user)

    get(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: Backend.Schema.User,
      interface: :playground,
      socket_url: "http://localhost:4000/user"
    )

    post(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: Backend.Schema.User,
      interface: :playground,
      socket_url: "http://localhost:4000/user"
    )
  end
end
