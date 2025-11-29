defmodule ForumWeb.StudioController do
  use ForumWeb, :controller

  alias Forum.Studios
  alias Forum.Studios.Studio

  action_fallback ForumWeb.FallbackController

  def index(conn, _params) do
    studios = Studios.list_studios()
    render(conn, :index, studios: studios)
  end

  def create(conn, %{"studio" => studio_params}) do
    with {:ok, %Studio{} = studio} <- Studios.create_studio(studio_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/studios/#{studio}")
      |> render(:show, studio: studio)
    end
  end

  def show(conn, %{"id" => id}) do
    studio = Studios.get_studio!(id)
    render(conn, :show, studio: studio)
  end

  def update(conn, %{"id" => id, "studio" => studio_params}) do
    studio = Studios.get_studio!(id)

    with {:ok, %Studio{} = studio} <- Studios.update_studio(studio, studio_params) do
      render(conn, :show, studio: studio)
    end
  end

  def delete(conn, %{"id" => id}) do
    studio = Studios.get_studio!(id)

    with {:ok, %Studio{}} <- Studios.delete_studio(studio) do
      send_resp(conn, :no_content, "")
    end
  end
end
