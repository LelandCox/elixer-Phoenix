defmodule ForumWeb.ProducerPageController do
  use ForumWeb, :controller

  alias Forum.Producers
  alias Forum.Producers.Producer
  alias Forum.Studios
  alias Forum.ProductionCompanies

  def index(conn, _params) do
    producers = Producers.list_producers()
    render(conn, :index, producers: producers)
  end

  def new(conn, _params) do
    changeset = Producers.change_producer(%Producer{})
    studios = Studios.list_studios()
    production_companies = ProductionCompanies.list_productioncompanies()

    render(conn, :new,
      changeset: changeset,
      studios: studios,
      production_companies: production_companies
    )
  end

  def create(conn, %{"producer" => producer_params}) do
    case Producers.create_producer(producer_params) do
      {:ok, producer} ->
        conn
        |> put_flash(:info, "Producer created successfully.")
        |> redirect(to: ~p"/producers/#{producer}")

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
    producer = Producers.get_producer!(id)
    render(conn, :show, producer: producer)
  end

  def edit(conn, %{"id" => id}) do
    producer = Producers.get_producer!(id)
    changeset = Producers.change_producer(producer)
    studios = Studios.list_studios()
    production_companies = ProductionCompanies.list_productioncompanies()

    render(conn, :edit,
      producer: producer,
      changeset: changeset,
      studios: studios,
      production_companies: production_companies
    )
  end

  def update(conn, %{"id" => id, "producer" => producer_params}) do
    producer = Producers.get_producer!(id)

    case Producers.update_producer(producer, producer_params) do
      {:ok, producer} ->
        conn
        |> put_flash(:info, "Producer updated successfully.")
        |> redirect(to: ~p"/producers/#{producer}")

      {:error, %Ecto.Changeset{} = changeset} ->
        studios = Studios.list_studios()
        production_companies = ProductionCompanies.list_productioncompanies()

        render(conn, :edit,
          producer: producer,
          changeset: changeset,
          studios: studios,
          production_companies: production_companies
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    producer = Producers.get_producer!(id)
    {:ok, _producer} = Producers.delete_producer(producer)

    conn
    |> put_flash(:info, "Producer deleted successfully.")
    |> redirect(to: ~p"/producers")
  end
end
