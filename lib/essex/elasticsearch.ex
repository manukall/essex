defmodule Essex.Elasticsearch do
  use HTTPoison.Base

  def process_request_body(body) do
    Poison.encode!(body)
  end

  def process_response_body(body) do
    Poison.decode!(body)
  end

  def process_url(url) do
    Application.get_env(:essex, :elasticsearch_url) <> "/" <> url
  end
end
