defmodule Forum.ProductionCompanies.ProductionCompany do
  use Ecto.Schema
  import Ecto.Changeset

  schema "productioncompanies" do
    field :name, :string
    field :financing, :boolean, default: false
    belongs_to :studio, Forum.Studios.Studio
    has_many :executives, Forum.Executives.Executive
    has_many :producers, Forum.Producers.Producer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(production_company, attrs) do
    production_company
    |> cast(attrs, [:name, :financing, :studio_id])
    |> validate_required([:name, :financing])
    |> unique_constraint(:name)
  end
end
