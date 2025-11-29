defmodule Forum.ProductionCompanies do
  @moduledoc """
  The ProductionCompanies context.
  """

  import Ecto.Query, warn: false
  alias Forum.Repo

  alias Forum.ProductionCompanies.ProductionCompany

  @doc """
  Returns the list of productioncompanies.

  ## Examples

      iex> list_productioncompanies()
      [%ProductionCompany{}, ...]

  """
  def list_productioncompanies do
    Repo.all(ProductionCompany)
    |> Repo.preload([:studio, :executives, :producers])
  end

  @doc """
  Gets a single production_company.

  Raises `Ecto.NoResultsError` if the Production company does not exist.

  ## Examples

      iex> get_production_company!(123)
      %ProductionCompany{}

      iex> get_production_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_production_company!(id) do
    Repo.get!(ProductionCompany, id)
    |> Repo.preload([:studio, :executives, :producers])
  end

  @doc """
  Creates a production_company.

  ## Examples

      iex> create_production_company(%{field: value})
      {:ok, %ProductionCompany{}}

      iex> create_production_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_production_company(attrs) do
    %ProductionCompany{}
    |> ProductionCompany.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, production_company} ->
        {:ok, Repo.preload(production_company, [:studio, :executives, :producers])}

      error ->
        error
    end
  end

  @doc """
  Updates a production_company.

  ## Examples

      iex> update_production_company(production_company, %{field: new_value})
      {:ok, %ProductionCompany{}}

      iex> update_production_company(production_company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_production_company(%ProductionCompany{} = production_company, attrs) do
    production_company
    |> ProductionCompany.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a production_company.

  ## Examples

      iex> delete_production_company(production_company)
      {:ok, %ProductionCompany{}}

      iex> delete_production_company(production_company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_production_company(%ProductionCompany{} = production_company) do
    Repo.delete(production_company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking production_company changes.

  ## Examples

      iex> change_production_company(production_company)
      %Ecto.Changeset{data: %ProductionCompany{}}

  """
  def change_production_company(%ProductionCompany{} = production_company, attrs \\ %{}) do
    ProductionCompany.changeset(production_company, attrs)
  end
end
