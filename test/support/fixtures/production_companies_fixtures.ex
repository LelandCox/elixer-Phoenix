defmodule Forum.ProductionCompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forum.ProductionCompanies` context.
  """

  @doc """
  Generate a production_company.
  """
  def production_company_fixture(attrs \\ %{}) do
    {:ok, production_company} =
      attrs
      |> Enum.into(%{
        financing: true,
        name: "some name"
      })
      |> Forum.ProductionCompanies.create_production_company()

    production_company
  end
end
