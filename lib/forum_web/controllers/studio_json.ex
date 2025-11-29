defmodule ForumWeb.StudioJSON do
  alias Forum.Studios.Studio

  @doc """
  Renders a list of studios.
  """
  def index(%{studios: studios}) do
    %{studios: for(studio <- studios, do: data(studio))}
  end

  @doc """
  Renders a single studio.
  """
  def show(%{studio: studio}) do
    %{studio: data(studio)}
  end

  defp data(%Studio{} = studio) do
    %{
      id: studio.id,
      name: studio.name,
      executives: for(executive <- studio.executives, do: executive.id),
      producers: for(producer <- studio.producers, do: producer.id),
      production_companies:
        for(production_company <- studio.production_companies, do: production_company.id)
    }
  end
end
