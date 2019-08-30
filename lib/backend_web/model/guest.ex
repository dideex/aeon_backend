defmodule Backend.Schema.Guest do
  use Absinthe.Schema
  alias Backend.Resolvers.Products

  query do
    field :get_products, list_of(:product) do
      resolve(&Products.get_products/2)
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
end
