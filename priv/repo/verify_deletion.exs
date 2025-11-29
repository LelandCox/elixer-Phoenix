alias Forum.Repo
alias Forum.Studios
alias Forum.Executives

# Create a studio and an executive
{:ok, studio} = Studios.create_studio(%{name: "Deletion Test Studio"})
{:ok, executive} = Executives.create_executive(%{name: "Deletion Test Exec", studio_id: studio.id})

IO.puts("Created Studio ID: #{studio.id}")
IO.puts("Created Executive ID: #{executive.id} with Studio ID: #{executive.studio_id}")

# Delete the studio
{:ok, _} = Studios.delete_studio(studio)
IO.puts("Deleted Studio ID: #{studio.id}")

# Check the executive
executive = Executives.get_executive!(executive.id)
IO.puts("Executive Studio ID after deletion: #{inspect(executive.studio_id)}")

if executive.studio_id == nil do
  IO.puts("SUCCESS: Executive studio_id is nil")
else
  IO.puts("FAILURE: Executive studio_id is not nil")
end
