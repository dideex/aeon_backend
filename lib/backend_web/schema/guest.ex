defmodule Backend.Schema.Guest do
  use Absinthe.Schema
  alias Backend.Resolvers.Person

  # import types
  import_types(Backend.Schema.Types)

  query do
    @spec "Test query returns user list"
    field :get_users, list_of(:person) do
      resolve(&Person.get_users/2)
    end
  end

  mutation do
    @spec "Register a new user"
    field :register_user, :person do
      arg(:input, non_null(:person_input))

      resolve(&Person.register_user/3)
    end

    @spec "Login user and return a jwt token"
    field :login_user, :session do
      arg(:input, non_null(:session_input))

      resolve(&Person.login_user/3)
    end

    @spec "Get all my info with token"
    field :me, :person do
      resolve(&Person.me/3)
    end
  end

  # subscription do
  #   field :product_added, :product do
  #     arg(:shop_id, non_null(:id))

  #     config(fn %{shop_id: shop_id}, _ ->
  #       {:ok, topic: shop_id}
  #     end)
  #   end
  # end
end
