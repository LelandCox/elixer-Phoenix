defmodule ForumWeb.ExecutiveJSON do
  alias Forum.Executives.Executive

  @doc """
  Renders a list of executives.
  """
  def index(%{executives: executives}) do
    %{executives: for(executive <- executives, do: data(executive))}
  end

  @doc """
  Renders a single executive.
  """
  def show(%{executive: executive}) do
    %{executive: data(executive)}
  end

  defp data(%Executive{} = executive) do
    %{
      id: executive.id,
      name: executive.name,
      studio_id: executive.studio_id,
      production_company_id: executive.production_company_id
    }
  end
end
