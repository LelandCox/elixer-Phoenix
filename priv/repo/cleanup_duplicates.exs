alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany
alias Forum.Executives.Executive
alias Forum.Producers.Producer
import Ecto.Query

IO.puts "Cleaning up duplicate studios..."

# Find duplicates
query = from s in Studio,
  group_by: s.name,
  having: count(s.name) > 1,
  select: s.name

duplicates = Repo.all(query)

for name <- duplicates do
  IO.puts "Processing duplicate Studio: #{name}"
  # Get all studios with this name, ordered by id
  studios = Repo.all(from s in Studio, where: s.name == ^name, order_by: [asc: :id])

  # Keep the first one, delete the rest
  [keep | delete_list] = studios

  for studio <- delete_list do
    IO.puts "Reassigning dependents from Studio ID: #{studio.id} to #{keep.id}"

    # Reassign Executives
    from(e in Executive, where: e.studio_id == ^studio.id)
    |> Repo.update_all(set: [studio_id: keep.id])

    # Reassign Producers
    from(p in Producer, where: p.studio_id == ^studio.id)
    |> Repo.update_all(set: [studio_id: keep.id])

    # Reassign ProductionCompanies
    from(pc in ProductionCompany, where: pc.studio_id == ^studio.id)
    |> Repo.update_all(set: [studio_id: keep.id])

    IO.puts "Deleting studio ID: #{studio.id}"
    Repo.delete(studio)
  end
end

IO.puts "Cleaning up duplicate production companies..."

# Find duplicates
query = from pc in ProductionCompany,
  group_by: pc.name,
  having: count(pc.name) > 1,
  select: pc.name

duplicates = Repo.all(query)

for name <- duplicates do
  IO.puts "Processing duplicate Production Company: #{name}"
  # Get all PCs with this name, ordered by id
  pcs = Repo.all(from pc in ProductionCompany, where: pc.name == ^name, order_by: [asc: :id])

  # Keep the first one, delete the rest
  [keep | delete_list] = pcs

  for pc <- delete_list do
    IO.puts "Reassigning dependents from PC ID: #{pc.id} to #{keep.id}"

    # Reassign Executives
    from(e in Executive, where: e.production_company_id == ^pc.id)
    |> Repo.update_all(set: [production_company_id: keep.id])

    # Reassign Producers
    from(p in Producer, where: p.production_company_id == ^pc.id)
    |> Repo.update_all(set: [production_company_id: keep.id])

    IO.puts "Deleting PC ID: #{pc.id}"
    Repo.delete(pc)
  end
end

IO.puts "Cleanup complete."
