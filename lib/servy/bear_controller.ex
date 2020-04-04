defmodule Servy.BearController do
  alias Servy.WildThings

  def index(conv) do
    items =
      WildThings.list_bears()
      |> Enum.filter(fn b -> b.type == "Brown" end)
      |> Enum.map(fn b -> "<li>#{b.name} - #{b.type}</li>" end)
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(conv, %{"id" => id}) do
    bear = WildThings.get_bear(id)
    %{conv | status: 200, resp_body: "<h1>Bear #{bear.name} - #{bear.type}</h1>"}
  end

  def create(conv, %{"type" => type, "name" => name}) do
    %{conv | status: 201, resp_body: "Created a #{type} Bear - #{name}"}
  end
end
