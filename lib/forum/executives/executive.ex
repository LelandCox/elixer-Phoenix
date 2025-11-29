defmodule Forum.Executives.Executive do
  use Ecto.Schema
  import Ecto.Changeset

  schema "executives" do
    field :name, :string
    field :title, :string
    belongs_to :production_company, Forum.ProductionCompanies.ProductionCompany
    belongs_to :studio, Forum.Studios.Studio

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(executive, attrs) do
    executive
    |> cast(attrs, [:name, :title, :studio_id, :production_company_id])
    |> validate_required([:name])
  end
end
