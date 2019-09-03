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

    #   field :test, :string do
    #     arg(:name, non_null(:string))

    #     resolve(fn %{name: name}, _ ->
    #       {:ok, "#{name} reply"}
    #     end)
    #   end
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
