defmodule Backend.Resolvers.Products do
  alias Backend.{Product, Repo, Shop}
  import Ecto.Query, only: [from: 2]
  alias Backend.Endpoint

  def get_products(%{user_id: user_id}, _) do
    # query =
    #   from(products in Product,
    #     join: shops in Shop,
    #     on: shops.id == products.shop_id,
    #     where: shops.owner_id == ^user_id
    #   )

    # {:ok, query |> Repo.all()}
    nil
  end

  def get_products(_, _) do
    # {:ok, Product |> Repo.all()}
    nil
  end

  # def create_product(%{user_id: user_id, shop_id: shop_id} = data, _) do
  #   amount = Map.get(data, :amount, 0)
  #   # shop_query = from(shops in Shop, where: shops.owner_id == ^user_id)
  #   with %Shop{} <- Shop |> Repo.get_by(owner_id: user_id, id: shop_id) do
  #     product = %{amount: 0} |> Map.merge(data) |> Map.drop(~w[user_id]a)
  #     {:ok, product} = %Product{} |> Product.changeset(product) |> Repo.insert()
  #     Absinthe.Subscription.publish(Endpoint, product, product_added: shop_id)
  #     {:ok, product}
  #   else
  #     nil -> {:error, "Wrong props"}
  #     error -> error
  #   end
  # end
end
