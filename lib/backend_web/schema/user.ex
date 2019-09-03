defmodule Backend.Schema.User do
  use Absinthe.Schema
  alias Backend.Resolvers.Products

  query do
    field :get_products, list_of(:product) do
      arg(:user_id, non_null(:id))
      resolve(&Products.get_products/2)
    end

    # field :test, :string do
    #   # FIXME: remove to context
    #   arg(:name, non_null(:string))

    #   resolve(fn %{name: name}, _ ->
    #     {:ok, "#{name} reply"}
    #   end)
    # end
  end

  # mutation do
  #   field :create_product, :product do
  #     # FIXME: remove to context
  #     arg(:user_id, non_null(:id))
  #     arg(:shop_id, non_null(:id))
  #     arg(:name, non_null(:string))
  #     arg(:price, non_null(:integer))
  #     arg(:amount, :integer)
  #     resolve(&Products.create_product/2)
  #   end
  # end

  object :product do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:price, :integer)
    field(:amount, :integer)
  end
end
