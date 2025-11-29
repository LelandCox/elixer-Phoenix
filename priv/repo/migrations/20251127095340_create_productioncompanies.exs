defmodule Forum.Repo.Migrations.CreateProductioncompanies do
  use Ecto.Migration

  def change do
    create table(:productioncompanies) do
      add :name, :string
      add :financing, :boolean, default: false, null: false
      add :studio_id, references(:studios, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:productioncompanies, [:studio_id])

    alter table(:executives) do
      add :production_company_id, references(:productioncompanies, on_delete: :nothing)
    end

    create index(:executives, [:production_company_id])

    alter table(:producers) do
      add :production_company_id, references(:productioncompanies, on_delete: :nothing)
    end

    create index(:producers, [:production_company_id])
  end
end
