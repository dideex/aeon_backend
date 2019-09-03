defmodule Backend.Jwt do
  use Guardian, otp_app: :backend
  require Backend.User

  def subject_for_token(user, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the user later, see
    # how it being used on `user_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    token = to_string(user.id)
    {:ok, token}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In `above subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.

    # id = claims["sub"]
    # resource = MyApp.get_resource_by_id(id)
    # {:ok, resource}
    user =
      claims["token"]
      |> User.get_user!()

    {:ok, user}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
