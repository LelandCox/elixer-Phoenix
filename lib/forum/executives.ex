defmodule Forum.Executives do
  @moduledoc """
  The Executives context.
  """

  import Ecto.Query, warn: false
  alias Forum.Repo

  alias Forum.Executives.Executive

  @doc """
  Returns the list of executives.

  ## Examples

      iex> list_executives()
      [%Executive{}, ...]

  """
  def list_executives do
    Repo.all(Executive)
    |> Repo.preload([:studio, :production_company])
  end

  @doc """
  Gets a single executive.

  Raises `Ecto.NoResultsError` if the Executive does not exist.

  ## Examples

      iex> get_executive!(123)
      %Executive{}

      iex> get_executive!(456)
      ** (Ecto.NoResultsError)

  """
  def get_executive!(id) do
    Repo.get!(Executive, id)
    |> Repo.preload([:studio, :production_company])
  end

  @doc """
  Creates a executive.

  ## Examples

      iex> create_executive(%{field: value})
      {:ok, %Executive{}}

      iex> create_executive(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_executive(attrs) do
    %Executive{}
    |> Executive.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, executive} -> {:ok, Repo.preload(executive, [:studio, :production_company])}
      error -> error
    end
  end

  @doc """
  Updates a executive.

  ## Examples

      iex> update_executive(executive, %{field: new_value})
      {:ok, %Executive{}}

      iex> update_executive(executive, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_executive(%Executive{} = executive, attrs) do
    executive
    |> Executive.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a executive.

  ## Examples

      iex> delete_executive(executive)
      {:ok, %Executive{}}

      iex> delete_executive(executive)
      {:error, %Ecto.Changeset{}}

  """
  def delete_executive(%Executive{} = executive) do
    Repo.delete(executive)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking executive changes.

  ## Examples

      iex> change_executive(executive)
      %Ecto.Changeset{data: %Executive{}}

  """
  def change_executive(%Executive{} = executive, attrs \\ %{}) do
    Executive.changeset(executive, attrs)
  end
end
