defmodule Essex.Client do
  alias Essex.Elasticsearch

  def index(index_name, type_name, data) do
    response = [index_name, type_name]
    |> join_url_segments
    |> Elasticsearch.post!(data)
    case response.status_code do
      201 -> {:ok, response.body}
      status_code -> {:error, status_code, response.body}
    end
  end

  def get(index_name, type_name, id) do
    response = [index_name, type_name, id]
    |> join_url_segments
    |> Elasticsearch.get!
    case response.status_code do
      200 -> {:ok, response.body}
      status_code -> {:error, status_code, response.body}
    end
  end

  def delete_index(index_name) do
    response = Elasticsearch.delete!(index_name)
    case response.status_code do
      200 -> {:ok, response.body}
      status_code -> {:error, status_code, response.body}
    end
  end

  def refresh_index(index_name) do
    response = [index_name, "_refresh"]
    |> join_url_segments
    |> Elasticsearch.post!(%{})

    case response.status_code do
      200 -> {:ok, response.body}
      status_code -> {:error, status_code, response.body}
    end
  end

  def search(index_name, type_name, params \\ nil) do
    url = join_url_segments( [index_name, type_name, "_search"])
    response = Elasticsearch.request!(:get, url, params)
    case response.status_code do
      200 -> {:ok, response.body}
      status_code -> {:error, status_code, response.body}
    end
  end


  defp join_url_segments(segments) do
    Enum.join(segments, "/")
  end

end
