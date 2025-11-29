defmodule ForumWeb.ProductionCompanyPageController do
  use ForumWeb, :controller

  alias Forum.ProductionCompanies
  alias Forum.ProductionCompanies.ProductionCompany
  alias Forum.Studios

  def index(conn, _params) do
    productioncompanies = ProductionCompanies.list_productioncompanies()
    render(conn, :index, productioncompanies: productioncompanies)
  end

  def new(conn, _params) do
    changeset = ProductionCompanies.change_production_company(%ProductionCompany{})
    studios = Studios.list_studios()
    render(conn, :new, changeset: changeset, studios: studios)
  end

  def create(conn, %{"production_company" => production_company_params}) do
    case ProductionCompanies.create_production_company(production_company_params) do
      {:ok, production_company} ->
        conn
        |> put_flash(:info, "Production company created successfully.")
        |> redirect(to: ~p"/productioncompanies/#{production_company}")

      {:error, %Ecto.Changeset{} = changeset} ->
        studios = Studios.list_studios()
        render(conn, :new, changeset: changeset, studios: studios)
    end
  end

  def show(conn, %{"id" => id}) do
    production_company = ProductionCompanies.get_production_company!(id)
    render(conn, :show, production_company: production_company)
  end

  def edit(conn, %{"id" => id}) do
    production_company = ProductionCompanies.get_production_company!(id)
    changeset = ProductionCompanies.change_production_company(production_company)
    studios = Studios.list_studios()

    render(conn, :edit,
      production_company: production_company,
      changeset: changeset,
      studios: studios
    )
  end

  def update(conn, %{"id" => id, "production_company" => production_company_params}) do
    production_company = ProductionCompanies.get_production_company!(id)

    case ProductionCompanies.update_production_company(
           production_company,
           production_company_params
         ) do
      {:ok, production_company} ->
        conn
        |> put_flash(:info, "Production company updated successfully.")
        |> redirect(to: ~p"/productioncompanies/#{production_company}")

      {:error, %Ecto.Changeset{} = changeset} ->
        studios = Studios.list_studios()

        render(conn, :edit,
          production_company: production_company,
          changeset: changeset,
          studios: studios
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    production_company = ProductionCompanies.get_production_company!(id)
    {:ok, _production_company} = ProductionCompanies.delete_production_company(production_company)

    conn
    |> put_flash(:info, "Production company deleted successfully.")
    |> redirect(to: ~p"/productioncompanies")
  end
end
