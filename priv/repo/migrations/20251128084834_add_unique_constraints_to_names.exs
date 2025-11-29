defmodule Forum.Repo.Migrations.AddUniqueConstraintsToNames do
  use Ecto.Migration

  def change do
    create unique_index(:studios, [:name])
    create unique_index(:productioncompanies, [:name])
  end
end
