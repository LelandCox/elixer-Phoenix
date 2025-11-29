defmodule ForumWeb.VisualizerController do
  use ForumWeb, :controller

  alias Forum.Studios
  alias Forum.Executives
  alias Forum.Producers
  alias Forum.ProductionCompanies

  def index(conn, _params) do
    studios = Studios.list_studios()
    executives = Executives.list_executives()
    producers = Producers.list_producers()
    production_companies = ProductionCompanies.list_productioncompanies()

    nodes =
      Enum.map(studios, fn s -> %{id: "studio_#{s.id}", label: s.name, group: "studio"} end) ++
        Enum.map(executives, fn e ->
          %{id: "executive_#{e.id}", label: e.name, group: "executive"}
        end) ++
        Enum.map(producers, fn p ->
          %{id: "producer_#{p.id}", label: p.name, group: "producer"}
        end) ++
        Enum.map(production_companies, fn pc ->
          %{id: "production_company_#{pc.id}", label: pc.name, group: "production_company"}
        end)

    edges =
      Enum.flat_map(executives, fn e ->
        [
          if(e.studio_id, do: %{from: "executive_#{e.id}", to: "studio_#{e.studio_id}"}),
          if(e.production_company_id,
            do: %{from: "executive_#{e.id}", to: "production_company_#{e.production_company_id}"}
          )
        ]
      end) ++
        Enum.flat_map(producers, fn p ->
          [
            if(p.studio_id, do: %{from: "producer_#{p.id}", to: "studio_#{p.studio_id}"}),
            if(p.production_company_id,
              do: %{from: "producer_#{p.id}", to: "production_company_#{p.production_company_id}"}
            )
          ]
        end) ++
        Enum.flat_map(production_companies, fn pc ->
          [
            if(pc.studio_id,
              do: %{from: "production_company_#{pc.id}", to: "studio_#{pc.studio_id}"}
            )
          ]
        end)

    # Filter out nils from edges
    edges = Enum.reject(edges, &is_nil/1)

    render(conn, :index, nodes: nodes, edges: edges)
  end
end
