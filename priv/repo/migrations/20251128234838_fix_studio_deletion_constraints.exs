defmodule Forum.Repo.Migrations.FixStudioDeletionConstraints do
  use Ecto.Migration

  def change do
    drop constraint(:executives, "executives_studio_id_fkey")

    alter table(:executives) do
      modify :studio_id, references(:studios, on_delete: :nilify_all)
    end

    drop constraint(:producers, "producers_studio_id_fkey")

    alter table(:producers) do
      modify :studio_id, references(:studios, on_delete: :nilify_all)
    end

    drop constraint(:productioncompanies, "productioncompanies_studio_id_fkey")

    alter table(:productioncompanies) do
      modify :studio_id, references(:studios, on_delete: :nilify_all)
    end
  end
end
