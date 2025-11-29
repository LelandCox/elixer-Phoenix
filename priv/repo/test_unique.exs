alias Forum.Repo
alias Forum.Studios.Studio
alias Forum.ProductionCompanies.ProductionCompany

IO.puts "Testing unique constraints..."

# Test Studio Uniqueness
IO.puts "Creating first studio 'Unique Studio'..."
{:ok, _} = Repo.insert(Studio.changeset(%Studio{}, %{name: "Unique Studio"}))

IO.puts "Attempting to create duplicate studio 'Unique Studio'..."
case Repo.insert(Studio.changeset(%Studio{}, %{name: "Unique Studio"})) do
  {:error, changeset} ->
    if changeset.errors[:name] do
      IO.puts "Success: Duplicate studio rejected."
    else
      IO.puts "Failure: Unexpected error: #{inspect(changeset.errors)}"
    end
  {:ok, _} -> IO.puts "Failure: Duplicate studio created."
end

# Test Production Company Uniqueness
IO.puts "Creating first PC 'Unique PC'..."
{:ok, _} = Repo.insert(ProductionCompany.changeset(%ProductionCompany{}, %{name: "Unique PC", financing: false}))

IO.puts "Attempting to create duplicate PC 'Unique PC'..."
case Repo.insert(ProductionCompany.changeset(%ProductionCompany{}, %{name: "Unique PC", financing: false})) do
  {:error, changeset} ->
    if changeset.errors[:name] do
      IO.puts "Success: Duplicate PC rejected."
    else
      IO.puts "Failure: Unexpected error: #{inspect(changeset.errors)}"
    end
  {:ok, _} -> IO.puts "Failure: Duplicate PC created."
end
