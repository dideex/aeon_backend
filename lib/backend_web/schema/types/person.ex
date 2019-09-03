defmodule Backend.Schema.Types.Person do
  use Absinthe.Schema.Notation

  object :person do
    field(:id, non_null(:id))
    field(:username, non_null(:string))
    field(:firstname, non_null(:string))
    field(:lastname, non_null(:string))
    field(:patronymic, :string)
    field(:gender, :string)
  end
end
