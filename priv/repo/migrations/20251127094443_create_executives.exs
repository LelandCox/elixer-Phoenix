defmodule Forum.Repo.Migrations.CreateExecutives do
  use Ecto.Migration

  def change do
    create table(:executives) do
      add :name, :string
      add :studio_id, references(:studios, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:executives, [:studio_id])
  end
end
