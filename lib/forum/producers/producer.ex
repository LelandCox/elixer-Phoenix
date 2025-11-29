defmodule Forum.Producers.Producer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "producers" do
    field :name, :string
    field :financing, :boolean, default: false
    belongs_to :production_company, Forum.ProductionCompanies.ProductionCompany
    belongs_to :studio, Forum.Studios.Studio

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(producer, attrs) do
    producer
    |> cast(attrs, [:name, :financing, :studio_id, :production_company_id])
    |> validate_required([:name, :financing])
  end
end
