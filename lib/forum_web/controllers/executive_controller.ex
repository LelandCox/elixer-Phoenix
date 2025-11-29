defmodule ForumWeb.ExecutiveController do
  use ForumWeb, :controller

  alias Forum.Executives
  alias Forum.Executives.Executive

  action_fallback ForumWeb.FallbackController

  def index(conn, _params) do
    executives = Executives.list_executives()
    render(conn, :index, executives: executives)
  end

  def create(conn, %{"executive" => executive_params}) do
    with {:ok, %Executive{} = executive} <- Executives.create_executive(executive_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/executives/#{executive}")
      |> render(:show, executive: executive)
    end
  end

  def show(conn, %{"id" => id}) do
    executive = Executives.get_executive!(id)
    render(conn, :show, executive: executive)
  end

  def update(conn, %{"id" => id, "executive" => executive_params}) do
    executive = Executives.get_executive!(id)

    with {:ok, %Executive{} = executive} <- Executives.update_executive(executive, executive_params) do
      render(conn, :show, executive: executive)
    end
  end

  def delete(conn, %{"id" => id}) do
    executive = Executives.get_executive!(id)

    with {:ok, %Executive{}} <- Executives.delete_executive(executive) do
      send_resp(conn, :no_content, "")
    end
  end
end
