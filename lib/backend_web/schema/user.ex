defmodule Backend.Schema.User do
  use Absinthe.Schema
  alias Backend.Resolvers.Person

  # import types
  import_types(Backend.Schema.Types)

  query do
    @spec "Test query returns user list"
    field :get_users, list_of(:person) do
      resolve(&Person.get_users/2)
    end

    # @spec "Test query returns user list"
    # field :get_users, list_of(:person) do
    #   resolve(&Person.get_users/2)
    # end

    @spec "Get all my info by the token"
    field :me, :person do
      resolve(&Person.me/3)
    end
  end
end
