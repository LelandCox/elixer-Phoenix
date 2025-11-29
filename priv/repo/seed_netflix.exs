alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany
import Ecto.Query

# Ensure Netflix studio exists
studio_name = "Netflix"
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
  "21 Laps",
  "40 Acres & A Mule (Spike Lee)",
  "42 (UK)",
  "606 Films (Halle Berry)",
  "Aggregate Films (Jason Bateman)",
  "All The King’s Horses (Joey King)",
  "Aluna Ent. (Vanessa Kirby)",
  "Anvil (Dean DeBlois - Animation)",
  "Berlanti/Schechter Films",
  "Bighead/Littlehead (Benioff/Weiss)",
  "Brutus Pink (Animation)",
  "Dark Horse Comics",
  "De Milo Films (J. Miles Dale)",
  "The Duffer Brothers",
  "Dylan Clark Productions",
  "Fierce Baby (Nahnatchka Kahn)",
  "Good One (Beau Bauman)",
  "Grand Electric (Newman)",
  "Higher Ground (Obamas)",
  "Hill District Media (Fuqua)",
  "Hivemind",
  "House 11/10 (Abdul-Mateen II)",
  "Korokoro (Omar Sy)",
  "Lea Productions (Bradley Cooper)",
  "Magic Quill",
  "Nine Hours (Edward Berger)",
  "Not A Real Company (Dan Levy)",
  "Nuyorican (J-Lo)",
  "RideBack",
  "Royal Ties (Regina King)",
  "Shondaland",
  "Stone Quarry (Zack Snyder)",
  "Story House (Forte & LeFauve)",
  "Tyler Perry Co.",
  "Vandalia (Jennifer Garner)",
  "Vertigo (Roy Lee)"
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
