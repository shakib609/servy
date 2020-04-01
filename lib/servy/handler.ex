defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> log
    |> route
    |> format_response
  end

  def log(conv), do: IO.inspect conv

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{
        method: method,
        path: path,
        status: nil,
        resp_body: ""
      }
  end

  def route(conv) do
    route(conv, conv.method, conv.path)
  end

  def route(conv, "GET", "/wildthings") do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(conv, "GET","/bears") do
    %{conv | status: 200, resp_body: "Paddington, Cody"}
  end

  def route(conv, "GET","/bears/" <> id) do
    %{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def route(conv, _method, path) do
    %{conv | status: 404, resp_body: "#{path} Not Found!"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_code_text(conv.status)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end

  defp status_code_text(code) do
    %{
      200 => "OK",
      201 => "Created",
      301 => "Redirect",
      404 => "Not Found!"
    }[code]
  end
end

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)
