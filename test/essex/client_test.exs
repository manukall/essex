defmodule Essex.ClientTest do
  use ExUnit.Case
  doctest Essex.Client

  alias Essex.Client

  @index_name "essex_test"

  test "index a document" do
    {:ok, response} = Client.index(@index_name, "employees", %{first_name: "Jane", last_name: "Smith"})
    assert response["created"] == true

    {:ok, document} = Client.get(@index_name, "employees", response["_id"])
    assert document["_source"]["first_name"] == "Jane"
    assert document["_source"]["last_name"] == "Smith"
  end
end
