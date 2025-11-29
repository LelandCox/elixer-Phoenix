defmodule ForumWeb.ExecutivePageController do
  use ForumWeb, :controller

  alias Forum.Executives
  alias Forum.Executives.Executive
  alias Forum.Studios
  alias Forum.ProductionCompanies

  def index(conn, _params) do
    executives = Executives.list_executives()
    render(conn, :index, executives: executives)
  end

  def new(conn, _params) do
    changeset = Executives.change_executive(%Executive{})
    studios = Studios.list_studios()
    production_companies = ProductionCompanies.list_productioncompanies()

    render(conn, :new,
      changeset: changeset,
      studios: studios,
      production_companies: production_companies
    )
  end

  def create(conn, %{"executive" => executive_params}) do
    case Executives.create_executive(executive_params) do
      {:ok, executive} ->
        conn
        |> put_flash(:info, "Executive created successfully.")
        |> redirect(to: ~p"/executives/#{executive}")

      {:error, %Ecto.Changeset{} = changeset} ->
        studios = Studios.list_studios()
        production_companies = ProductionCompanies.list_productioncompanies()

        render(conn, :new,
          changeset: changeset,
          studios: studios,
          production_companies: production_companies
        )
    end
  end

  def show(conn, %{"id" => id}) do
    executive = Executives.get_executive!(id)
    render(conn, :show, executive: executive)
  end

  def edit(conn, %{"id" => id}) do
    executive = Executives.get_executive!(id)
    changeset = Executives.change_executive(executive)
    studios = Studios.list_studios()
    production_companies = ProductionCompanies.list_productioncompanies()

    render(conn, :edit,
      executive: executive,
      changeset: changeset,
      studios: studios,
      production_companies: production_companies
    )
  end

  def update(conn, %{"id" => id, "executive" => executive_params}) do
    executive = Executives.get_executive!(id)

    case Executives.update_executive(executive, executive_params) do
      {:ok, executive} ->
        conn
        |> put_flash(:info, "Executive updated successfully.")
        |> redirect(to: ~p"/executives/#{executive}")

      {:error, %Ecto.Changeset{} = changeset} ->
        studios = Studios.list_studios()
        production_companies = ProductionCompanies.list_productioncompanies()

        render(conn, :edit,
          executive: executive,
          changeset: changeset,
          studios: studios,
          production_companies: production_companies
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    executive = Executives.get_executive!(id)
    {:ok, _executive} = Executives.delete_executive(executive)

    conn
    |> put_flash(:info, "Executive deleted successfully.")
    |> redirect(to: ~p"/executives")
  end
end
