alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany
import Ecto.Query

# Ensure Sony studio exists
studio_name = "Sony"
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
  "Appian Way",
  "2.0 Entertainment",
  "Bay Films",
  "Billy17 (Tom Holland)",
  "Chronology (Heisserer)",
  "Color Force",
  "Escape Artists",
  "Form, Andrew",
  "Golden Gate (Luke Scrase)",
  "Modern Magic (Rosenberg & Rothman)",
  "Mortal Media (Blake Griffin)",
  "Oddball Ent. (Wes Ball)",
  "Olive Bridge (Will Gluck)",
  "Hutch Parker Ent.",
  "Hyperobject Industries (McKay)",
  "Piece of Work (Lee Eisenberg)",
  "Jason Reitman & Gil Kenan",
  "Speck+Gordon",
  "Unknown Quantity (Chris Bremner)"
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
