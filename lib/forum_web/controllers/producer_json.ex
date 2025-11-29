defmodule ForumWeb.ProducerJSON do
  alias Forum.Producers.Producer

  @doc """
  Renders a list of producers.
  """
  def index(%{producers: producers}) do
    %{producers: for(producer <- producers, do: data(producer))}
  end

  @doc """
  Renders a single producer.
  """
  def show(%{producer: producer}) do
    %{producer: data(producer)}
  end

  defp data(%Producer{} = producer) do
    %{
      id: producer.id,
      name: producer.name,
      financing: producer.financing,
      studio_id: producer.studio_id,
      production_company_id: producer.production_company_id
    }
  end
end
