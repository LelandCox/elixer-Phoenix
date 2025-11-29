alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany
import Ecto.Query

# Ensure Lionsgate studio exists
studio_name = "Lionsgate"
studio = Repo.get_by(Studio, name: studio_name)

studio =
  if studio do
    IO.puts("Found existing studio: #{studio.name}")
    studio
  else
    IO.puts("Creating studio: #{studio_name}")
    {:ok, studio} =
      %Studio{}
      |> Studio.changeset(%{name: studio_name})
      |> Repo.insert()
    studio
  end

companies = [
  "3Pas Studios",
  "87Eleven (Chad Stahelski)",
  "Burr! Productions",
  "CineMachine (Ric Roman Waugh)",
  "Grindstone",
  "Hidden Pictures (Leiberman & Young)",
  "Made With Love (Stephen Love)",
  "Megamix (Levine & Bohrer)",
  "Super Ego (Ben Karlin)"
]

for company_name <- companies do
  # Check if company already exists
  existing = Repo.get_by(ProductionCompany, name: company_name)

  if existing do
    IO.puts("Skipping existing company: #{company_name}")
  else
    IO.puts("Creating company: #{company_name}")
    %ProductionCompany{}
    |> ProductionCompany.changeset(%{name: company_name, studio_id: studio.id})
    |> Repo.insert!()
  end
end

IO.puts("Seeding complete!")
