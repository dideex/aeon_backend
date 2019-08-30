defmodule BackendWeb.Router do
  use BackendWeb, :router

  scope "/guest" do
    forward(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: Backend.Schema.Guest,
      socket_url: "http://localhost:4000/guest"
    )
  end

  scope "/user" do
    get(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: Backend.Schema.User,
      socket_url: "http://localhost:4000/user"
    )

    post(
      "/graphql",
      Absinthe.Plug.GraphiQL,
      schema: Backend.Schema.User,
      socket_url: "http://localhost:4000/user"
    )
  end
end
