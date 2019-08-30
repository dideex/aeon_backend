defmodule Backend.User.Encryption do
  alias Comeonin.Bcrypt
  import Ecto.{Query, Changeset}, warn: false

  def password_hashing(password), do: Bcrypt.hashpwsalt(password)
  def validate_password(password, hash), do: Bcrypt.checkpw(password, hash)

  def hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, password_hashing(password))

      _ ->
        changeset
    end
  end
end
