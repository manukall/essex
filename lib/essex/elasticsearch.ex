defmodule Essex.Elasticsearch do
  use HTTPoison.Base

  def process_request_body(nil), do: ""
  def process_request_body(body) do
    Poison.encode!(body)
  end

  def process_response_body(body) do
    Poison.decode!(body)
  end

  def process_url(url) do
    base_url <> "/" <> url
  end

  def base_url do
    case Application.get_env(:essex, :elasticsearch_url) do
      nil -> raise("Please set the ':essex, :elasticsearch_url' application config")
      url -> url
    end
  end
end
