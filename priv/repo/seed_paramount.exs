alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany
import Ecto.Query

# Ensure Paramount studio exists
studio_name = "Paramount"
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
  "18hz* (Walter Hamada)",
  "Broken Road",
  "Bruckheimer",
  "Finn, Parker",
  "Flitcraft (Scott Frank)",
  "Franklin Entertainment (DeVon)",
  "GoldDay (Daley & Goldstein)",
  "Grey Skies (Steven Caple Jr.)",
  "Khalabo Ink (Kenya Barris)",
  "Lab Brew (Lindsey Beer)",
  "Maximum Effort (Ryan Reynolds)",
  "New Republic",
  "Original Film",
  "QC Entertainment",
  "Rock the Bells (LL Cool J)",
  "Sunday Night (Krasinski)",
  "Temple Hill",
  "Wild Chickens (Chazelle)"
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
