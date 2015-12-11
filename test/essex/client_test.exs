defmodule Essex.ClientTest do
  use ExUnit.Case
  doctest Essex.Client

  alias Essex.Client

  @index_name "essex_test"
  @type_name "employees"

  setup do
    Client.delete_index(@index_name)
    Client.refresh_index(@index_name)
    :ok
  end

  test "index a document" do
    {:ok, response} = Client.index(@index_name, @type_name, %{first_name: "Jane", last_name: "Smith"})
    assert response["created"] == true

    {:ok, document} = Client.get(@index_name, @type_name, response["_id"])
    assert document["_source"]["first_name"] == "Jane"
    assert document["_source"]["last_name"] == "Smith"
  end

  test "delete an index" do
    {:ok, %{"_id" => id}} = Client.index(@index_name, @type_name, %{first_name: "Jane", last_name: "Smith"})

    Client.delete_index(@index_name)
    {:error, 404, _} = Client.get(@index_name, @type_name, id)
  end

  test "search" do
    {:ok, _} = Client.index(@index_name, @type_name, %{first_name: "Jane", last_name: "Smith"})
    {:ok, _} = Client.index(@index_name, @type_name, %{first_name: "John", last_name: "Smith"})

    {:ok, _} = Client.refresh_index(@index_name)

    {:ok, %{"hits" => %{"total" => 2}}} = Client.search(@index_name, @type_name)
  end
end
