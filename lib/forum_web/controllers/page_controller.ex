defmodule ForumWeb.PageController do
  use ForumWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def users(conn, _params) do
    # IO.puts("users function hit")
    users = [
      %{id: 1, name: "Dana", email: "dana@northstarla.com"},
      %{id: 2, name: "Leland", email: "leland.j.cox@gmail.com"}
    ]
    # render(conn, :users, users: users, layout: false)
    json(conn, %{users: users})
  end

end
