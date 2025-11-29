defmodule Forum.Repo.Migrations.CreateStudios do
  use Ecto.Migration

  def change do
    create table(:studios) do
      add :name, :string
      timestamps(type: :utc_datetime)
    end
  end
end
