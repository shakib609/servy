defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")
    [request_line | headers_string] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(headers_string, %{})
    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  def parse_headers([h | t], headers) do
    [key, value] = String.split(h, ": ")
    headers = Map.put(headers, key, value)
    parse_headers(t, headers)
  end

  def parse_headers([], headers), do: headers

  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}
end
