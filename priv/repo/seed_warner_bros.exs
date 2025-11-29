alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany
import Ecto.Query

# Ensure Warner Brothers studio exists
studio_name = "Warner Brothers"
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
  "6th & Idaho (Matt Reeves)",
  "Bad Robot",
  "Bazmark Films (Baz Luhrmann)",
  "Chalamet, Timothée",
  "Cruise, Tom",
  "De Line",
  "Double Dream (Muschiettis)",
  "Electric Somewhere (Jon Chu)",
  "Gerber Pictures",
  "Heyday (David Heyman)",
  "Icki Eneo Arlo (R. Pattinson)",
  "Joint Effort (Bradley C. /Todd P.)",
  "LuckyChap (Margot Robbie)",
  "Mad Ghost (Geoff Johns)",
  "Malpaso (Clint Eastwood)",
  "Persons Attempting (Nee Bros.)",
  "PictureStart",
  "Plan B",
  "The Safran Co.",
  "Smokehouse",
  "Spyglass",
  "That’s Wonderful (Jim Parsons)",
  "Wigram Productions"
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
