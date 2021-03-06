defmodule Backend.Jwt do
  use Guardian, otp_app: :backend
  alias Backend.Repo.User

  def subject_for_token(%User{} = user, _claims) do
    {:ok, to_string(user.id)}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    case User.get_user!(id) do
      nil -> {:error, :no_resources}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
