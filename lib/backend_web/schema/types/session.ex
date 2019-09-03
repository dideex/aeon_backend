defmodule Backend.Schema.Types.Session do
  use Absinthe.Schema.Notation

  object :session do
    field(:token, :string)
    field(:user, :person)
  end

  input_object :session_input do
    field(:username, non_null(:string))
    field(:password, non_null(:string))
  end
end
