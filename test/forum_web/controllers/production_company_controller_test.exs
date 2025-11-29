defmodule ForumWeb.ProductionCompanyControllerTest do
  use ForumWeb.ConnCase

  import Forum.ProductionCompaniesFixtures
  alias Forum.ProductionCompanies.ProductionCompany

  @create_attrs %{
    name: "some name",
    financing: true
  }
  @update_attrs %{
    name: "some updated name",
    financing: false
  }
  @invalid_attrs %{name: nil, financing: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all productioncompanies", %{conn: conn} do
      conn = get(conn, ~p"/api/productioncompanies")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create production_company" do
    test "renders production_company when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/productioncompanies", production_company: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/productioncompanies/#{id}")

      assert %{
               "id" => ^id,
               "financing" => true,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/productioncompanies", production_company: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update production_company" do
    setup [:create_production_company]

    test "renders production_company when data is valid", %{conn: conn, production_company: %ProductionCompany{id: id} = production_company} do
      conn = put(conn, ~p"/api/productioncompanies/#{production_company}", production_company: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/productioncompanies/#{id}")

      assert %{
               "id" => ^id,
               "financing" => false,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, production_company: production_company} do
      conn = put(conn, ~p"/api/productioncompanies/#{production_company}", production_company: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete production_company" do
    setup [:create_production_company]

    test "deletes chosen production_company", %{conn: conn, production_company: production_company} do
      conn = delete(conn, ~p"/api/productioncompanies/#{production_company}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/productioncompanies/#{production_company}")
      end
    end
  end

  defp create_production_company(_) do
    production_company = production_company_fixture()

    %{production_company: production_company}
  end
end
