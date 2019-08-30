defmodule Backend.Schema.Guest do
  use Absinthe.Schema
  alias Backend.Resolvers.Person

  query do
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

  object :product do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:price, :integer)
    field(:amount, :integer)
  end

  object :person do
    field(:id, non_null(:id))
    field(:username, non_null(:string))
    field(:firstname, non_null(:string))
    field(:lastname, non_null(:string))
    field(:patronymic, :string)
    field(:gender, :string)
  end
end
