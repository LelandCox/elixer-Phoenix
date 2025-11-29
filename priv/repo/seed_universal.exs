alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany
import Ecto.Query

# Ensure Universal studio exists
studio_name = "Universal"
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
  "87th North (David Leitch)",
  "Amblin",
  "Apatow Productions",
  "Atomic Monster",
  "Barnstorm (Glenn Powell)",
  "Blumhouse",
  "Comet (Jamie Lee Curtis)",
  "Greyeyes, Michael",
  "Paper Pics (Carla Hacken)",
  "Whannell, Leigh",
  "Broadway Video",
  "Brownstone (Elizabeth Banks)",
  "Captivate (Ludlum)",
  "The Daniels",
  "Denver & Delilah (Theron)",
  "Feigco Entertainment",
  "Fruit Tree (Emma Stone)",
  "Great Company (Krysty W-C)",
  "Lord & Miller",
  "MonkeyPaw (Jordan Peele)",
  "Nicholas Sparks & Anonymous",
  "One Race (Vin Diesel)",
  "Will Packer Productions",
  "Platinum Dunes (Bay & Fuller)",
  "Marc Platt Co.",
  "Point Grey (Rogen, Goldberg, Weaver)",
  "SpringHill Co."
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
