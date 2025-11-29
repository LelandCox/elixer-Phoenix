defmodule ForumWeb.ProductionCompanyController do
  use ForumWeb, :controller

  alias Forum.ProductionCompanies
  alias Forum.ProductionCompanies.ProductionCompany

  action_fallback ForumWeb.FallbackController

  def index(conn, _params) do
    productioncompanies = ProductionCompanies.list_productioncompanies()
    render(conn, :index, productioncompanies: productioncompanies)
  end

  def create(conn, %{"production_company" => production_company_params}) do
    with {:ok, %ProductionCompany{} = production_company} <- ProductionCompanies.create_production_company(production_company_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/productioncompanies/#{production_company}")
      |> render(:show, production_company: production_company)
    end
  end

  def show(conn, %{"id" => id}) do
    production_company = ProductionCompanies.get_production_company!(id)
    render(conn, :show, production_company: production_company)
  end

  def update(conn, %{"id" => id, "production_company" => production_company_params}) do
    production_company = ProductionCompanies.get_production_company!(id)

    with {:ok, %ProductionCompany{} = production_company} <- ProductionCompanies.update_production_company(production_company, production_company_params) do
      render(conn, :show, production_company: production_company)
    end
  end

  def delete(conn, %{"id" => id}) do
    production_company = ProductionCompanies.get_production_company!(id)

    with {:ok, %ProductionCompany{}} <- ProductionCompanies.delete_production_company(production_company) do
      send_resp(conn, :no_content, "")
    end
  end
end
