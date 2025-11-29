defmodule Forum.Studios.Studio do
  use Ecto.Schema
  import Ecto.Changeset

  schema "studios" do
    field :name, :string
    has_many :executives, Forum.Executives.Executive, on_replace: :nilify
    has_many :producers, Forum.Producers.Producer, on_replace: :nilify
    has_many :production_companies, Forum.ProductionCompanies.ProductionCompany

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(studio, attrs) do
    studio
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
