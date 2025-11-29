alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany
import Ecto.Query

# Ensure Amazon/MGM studio exists
studio_name = "Amazon/MGM"
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
  "AllyCat (Alan Ritchson)",
  "Balboa Productions (Stallone)",
  "Borderless (Steven Prinz)",
  "Critical Role",
  "De La Revolución (Matsoukas)",
  "Di Novi Pictures",
  "DJ2 Entertainment",
  "Electric Shepherd (Philip K. Dick)",
  "Free Association (Tatum)",
  "General Admission (Gosling)",
  "Iam21 (Nnamdi Asomugh)",
  "Imagine",
  "Washington Post",
  "Major League Baseball",
  "Jack Tar (Resteghini)",
  "Jenny Kissed Me (Jenny Han)",
  "MACRO (Charles King)",
  "Nine Stories (Gyllenhaal)",
  "Outlier Society (Michael B. Jordan)",
  "Pascal Pictures",
  "Premeditated (Pelletier/Clark)",
  "Purple Pebble (Priyanka Chopra)",
  "Quesada, Joe",
  "Rockwood (David Kosse – UK)",
  "Bird Runningwater Co.",
  "Safehouse (Harold/Tunnell)",
  "Sister (w/Amazon UK)",
  "Wychwood (David Yates)",
  "Animal (Natasha Lyonne)",
  "Small Victory* (Lili Reinhart)",
  "Story Kitchen",
  "Three Amigos (Diego Bonita)",
  "Jennifer Todd Pictures",
  "Viva Maude (Tessa Thompson)",
  "Weed Road"
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
