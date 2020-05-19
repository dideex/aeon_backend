defmodule Backend.User.Auth do
  alias Backend.Repo

  def authenticate(%{username: username, password: password}) do
    user = Repo.get_by(Repo.User, username: String.downcase(username))

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, "Could not login"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> User.Encryption.validate_password(password, user.password)
    end
  end
end
