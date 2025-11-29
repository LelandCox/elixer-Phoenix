defmodule Forum.Repo.Migrations.AddTitleToExecutives do
  use Ecto.Migration

  def change do
    alter table(:executives) do
      add :title, :string
    end
  end
end
