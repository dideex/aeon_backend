defmodule Backend.Schema.User do
  use Absinthe.Schema
  alias Backend.Resolvers.Person

  # import types
  import_types(Backend.Schema.Types)

  query do
    @spec "Test query returns user list"
    field :get_users, list_of(:person) do
      resolve(&Person.get_users/3)
    end
  end
end
