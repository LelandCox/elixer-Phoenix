defmodule ForumWeb.ExecutiveControllerTest do
  use ForumWeb.ConnCase

  import Forum.ExecutivesFixtures
  alias Forum.Executives.Executive

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all executives", %{conn: conn} do
      conn = get(conn, ~p"/api/executives")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create executive" do
    test "renders executive when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/executives", executive: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/executives/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/executives", executive: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update executive" do
    setup [:create_executive]

    test "renders executive when data is valid", %{conn: conn, executive: %Executive{id: id} = executive} do
      conn = put(conn, ~p"/api/executives/#{executive}", executive: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/executives/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, executive: executive} do
      conn = put(conn, ~p"/api/executives/#{executive}", executive: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete executive" do
    setup [:create_executive]

    test "deletes chosen executive", %{conn: conn, executive: executive} do
      conn = delete(conn, ~p"/api/executives/#{executive}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/executives/#{executive}")
      end
    end
  end

  defp create_executive(_) do
    executive = executive_fixture()

    %{executive: executive}
  end
end
