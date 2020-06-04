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

  object :post do
    field :id, :id
    field :created, :integer
    field :title, :string
    field :body, :string
    field :photo, :string
    field :views, :integer
  end

  object :notification do
    field :id, :id
    field :title, :string
    field :body, :string
    field :type, :string
  end

  input_object :person_input do
    field(:username, non_null(:string))
    field(:password, non_null(:string))
    field(:firstname, non_null(:string))
    field(:lastname, non_null(:string))
    field(:birthdate, non_null(:birthdate_input))
    field(:gender, :string)
    field(:city, :string)
  end

  input_object :birthdate_input do
    field(:month, non_null(:integer))
    field(:year, non_null(:integer))
    field(:day, non_null(:integer))
  end
end
