defmodule Servy.Conv do
  defstruct method: "", path: "", resp_body: "", status: nil

  def full_status(conv) do
    "#{conv.status} #{status_code_text(conv.status)}"
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
