defmodule Essex.Client do
  alias Essex.Elasticsearch

  def index(index_name, type, data) do
    response = Elasticsearch.post!(index_name <> "/" <> type, data)
    {:ok, response.body}
  end

  def get(index_name, type, id) do
    response = Elasticsearch.get!(index_name <> "/" <> type <> "/" <> id)
    {:ok, response.body}
  end

end
