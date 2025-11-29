defmodule Forum.Studios do
  @moduledoc """
  The Studios context.
  """

  import Ecto.Query, warn: false
  alias Forum.Repo

  alias Forum.Studios.Studio
  alias Forum.Executives.Executive
  alias Forum.Producers.Producer

  @doc """
  Returns the list of studios.

  ## Examples

      iex> list_studios()
      [%Studio{}, ...]

  """
  def list_studios do
    Repo.all(Studio)
    |> Repo.preload([:executives, :producers, :production_companies])
  end

  @doc """
  Gets a single studio.

  Raises `Ecto.NoResultsError` if the Studio does not exist.

  ## Examples

      iex> get_studio!(123)
      %Studio{}

      iex> get_studio!(456)
      ** (Ecto.NoResultsError)

  """
  def get_studio!(id) do
    Repo.get!(Studio, id)
    |> Repo.preload([:executives, :producers, :production_companies])
  end

  @doc """
  Creates a studio.

  ## Examples

      iex> create_studio(%{field: value})
      {:ok, %Studio{}}

      iex> create_studio(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_studio(attrs) do
    executive_ids = attrs["executive_ids"] || attrs[:executive_ids] || []
    producer_ids = attrs["producer_ids"] || attrs[:producer_ids] || []

    executives = Repo.all(from e in Executive, where: e.id in ^executive_ids)
    producers = Repo.all(from p in Producer, where: p.id in ^producer_ids)

    %Studio{}
    |> Studio.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:executives, executives)
    |> Ecto.Changeset.put_assoc(:producers, producers)
    |> Repo.insert()
    |> case do
      {:ok, studio} ->
        {:ok, Repo.preload(studio, [:executives, :producers, :production_companies])}

      error ->
        error
    end
  end

  @doc """
  Updates a studio.

  ## Examples

      iex> update_studio(studio, %{field: new_value})
      {:ok, %Studio{}}

      iex> update_studio(studio, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_studio(%Studio{} = studio, attrs) do
    executive_ids = attrs["executive_ids"] || attrs[:executive_ids] || []
    producer_ids = attrs["producer_ids"] || attrs[:producer_ids] || []

    executives = Repo.all(from e in Executive, where: e.id in ^executive_ids)
    producers = Repo.all(from p in Producer, where: p.id in ^producer_ids)

    studio
    |> Studio.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:executives, executives)
    |> Ecto.Changeset.put_assoc(:producers, producers)
    |> Repo.update()
  end

  @doc """
  Deletes a studio.

  ## Examples

      iex> delete_studio(studio)
      {:ok, %Studio{}}

      iex> delete_studio(studio)
      {:error, %Ecto.Changeset{}}

  """
  def delete_studio(%Studio{} = studio) do
    Repo.delete(studio)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking studio changes.

  ## Examples

      iex> change_studio(studio)
      %Ecto.Changeset{data: %Studio{}}

  """
  def change_studio(%Studio{} = studio, attrs \\ %{}) do
    Studio.changeset(studio, attrs)
  end
end
