defmodule Forum.Repo.Migrations.CreateProducers do
  use Ecto.Migration

  def change do
    create table(:producers) do
      add :name, :string
      add :financing, :boolean, default: false, null: false
      add :studio_id, references(:studios, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:producers, [:studio_id])
  end
end
