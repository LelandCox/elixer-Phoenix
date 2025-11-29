defmodule ForumWeb.ProductionCompanyJSON do
  alias Forum.ProductionCompanies.ProductionCompany

  @doc """
  Renders a list of productioncompanies.
  """
  def index(%{productioncompanies: productioncompanies}) do
    %{
      productioncompanies:
        for(production_company <- productioncompanies, do: data(production_company))
    }
  end

  @doc """
  Renders a single production_company.
  """
  def show(%{production_company: production_company}) do
    %{production_company: data(production_company)}
  end

  defp data(%ProductionCompany{} = production_company) do
    %{
      id: production_company.id,
      name: production_company.name,
      financing: production_company.financing,
      studio_id: production_company.studio_id,
      executives: for(executive <- production_company.executives, do: executive.id),
      producers: for(producer <- production_company.producers, do: producer.id)
    }
  end
end
