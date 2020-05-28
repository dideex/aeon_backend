defmodule Backend.Plugs.Context do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn) |> IO.inspect(label: :context)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, claims} <- Backend.Jwt.decode_and_verify(token),
         {:ok, user} <- Backend.Jwt.resource_from_claims(claims) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
