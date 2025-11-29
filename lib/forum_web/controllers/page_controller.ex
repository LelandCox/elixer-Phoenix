defmodule ForumWeb.PageController do
  use ForumWeb, :controller

  alias Forum.Studios
  alias Forum.Executives
  alias Forum.Producers
  alias Forum.ProductionCompanies

  def home(conn, _params) do
    studios = Studios.list_studios()
    executives = Executives.list_executives()
    producers = Producers.list_producers()
    production_companies = ProductionCompanies.list_productioncompanies()

    render(conn, :home,
      studios: studios,
      executives: executives,
      producers: producers,
      productioncompanies: production_companies
    )
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
