defmodule ForumWeb.StudioControllerTest do
  use ForumWeb.ConnCase

  import Forum.StudiosFixtures
  alias Forum.Studios.Studio

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
    test "lists all studios", %{conn: conn} do
      conn = get(conn, ~p"/api/studios")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create studio" do
    test "renders studio when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/studios", studio: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/studios/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/studios", studio: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update studio" do
    setup [:create_studio]

    test "renders studio when data is valid", %{conn: conn, studio: %Studio{id: id} = studio} do
      conn = put(conn, ~p"/api/studios/#{studio}", studio: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/studios/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, studio: studio} do
      conn = put(conn, ~p"/api/studios/#{studio}", studio: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete studio" do
    setup [:create_studio]

    test "deletes chosen studio", %{conn: conn, studio: studio} do
      conn = delete(conn, ~p"/api/studios/#{studio}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/studios/#{studio}")
      end
    end
  end

  defp create_studio(_) do
    studio = studio_fixture()

    %{studio: studio}
  end
end
