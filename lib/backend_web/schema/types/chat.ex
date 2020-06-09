defmodule Backend.Schema.Types.Chat do
  use Absinthe.Schema.Notation

  object :chat_message do
    field(:id, non_null(:id))
    field(:body, non_null(:string))
    field(:sender, non_null(:person))
    field(:created, :integer)
  end

  object :chat_topic do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:image, non_null(:string))
    field(:group, non_null(:boolean))
    field(:created, :integer)
  end
end
