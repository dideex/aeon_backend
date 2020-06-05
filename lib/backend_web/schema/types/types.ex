defmodule Backend.Schema.Types do
  use Absinthe.Schema.Notation
  alias Backend.Schema.Types

  import_types(Types.Session)
  import_types(Types.Person)
  import_types(Types.Chat)
end
