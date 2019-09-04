defmodule Backend.Resolvers.Person do
  import Ecto.Query, only: [from: 2]
  alias Backend.Endpoint
  alias Backend.{User, Repo, Jwt}

  # Queries
  def get_users(_, _) do
    {:ok, User.get_all()}
  end

  # Queries
  def get_users(_, _, %{context: context}) do
    IO.inspect(context)
    {:ok, User.get_all()}
  end

  # Mutations
  def register_user(_, %{input: input}, _) do
    User.create_user(input)
  end

  def login_user(_, %{input: input}, _) do
    with {:ok, user} <- User.Auth.authenticate(input),
         {:ok, jwt_token, _} <- Jwt.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
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
