defmodule Servy.WildThings do
  alias Servy.Bear

  def list_bears do
    [
      %Bear{id: 1, name: "Teddy", type: "Brown", hibernating: true},
      %Bear{id: 2, name: "Smokey", type: "Brown"},
      %Bear{id: 3, name: "Paddington", type: "Black"},
      %Bear{id: 4, name: "Scarface", type: "Grizzly", hibernating: true}
    ]
  end

  def get_bear(id) when is_integer(id) do
    Enum.find(list_bears(), fn b -> b.id == id end)
  end

  def get_bear(id) when is_binary(id) do
    String.to_integer(id) |> get_bear
  end
end
