defmodule ForumWeb.StudioPageController do
  use ForumWeb, :controller

  alias Forum.Studios
  alias Forum.Studios.Studio
  alias Forum.Executives
  alias Forum.Producers

  def index(conn, _params) do
    studios = Studios.list_studios()
    render(conn, :index, studios: studios)
  end

  def new(conn, _params) do
    changeset = Studios.change_studio(%Studio{})
    executives = Executives.list_executives()
    producers = Producers.list_producers()
    render(conn, :new, changeset: changeset, executives: executives, producers: producers)
  end

  def create(conn, %{"studio" => studio_params}) do
    case Studios.create_studio(studio_params) do
      {:ok, studio} ->
        conn
        |> put_flash(:info, "Studio created successfully.")
        |> redirect(to: ~p"/studios/#{studio}")

      {:error, %Ecto.Changeset{} = changeset} ->
        executives = Executives.list_executives()
        producers = Producers.list_producers()
        render(conn, :new, changeset: changeset, executives: executives, producers: producers)
    end
  end

  def show(conn, %{"id" => id}) do
    studio = Studios.get_studio!(id)
    render(conn, :show, studio: studio)
  end

  def edit(conn, %{"id" => id}) do
    studio = Studios.get_studio!(id)
    changeset = Studios.change_studio(studio)
    executives = Executives.list_executives()
    producers = Producers.list_producers()

    render(conn, :edit,
      studio: studio,
      changeset: changeset,
      executives: executives,
      producers: producers
    )
  end

  def update(conn, %{"id" => id, "studio" => studio_params}) do
    studio = Studios.get_studio!(id)

    case Studios.update_studio(studio, studio_params) do
      {:ok, studio} ->
        conn
        |> put_flash(:info, "Studio updated successfully.")
        |> redirect(to: ~p"/studios/#{studio}")

      {:error, %Ecto.Changeset{} = changeset} ->
        executives = Executives.list_executives()
        producers = Producers.list_producers()

        render(conn, :edit,
          studio: studio,
          changeset: changeset,
          executives: executives,
          producers: producers
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    studio = Studios.get_studio!(id)
    {:ok, _studio} = Studios.delete_studio(studio)

    conn
    |> put_flash(:info, "Studio deleted successfully.")
    |> redirect(to: ~p"/studios")
  end
end
