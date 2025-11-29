alias Forum.Repo
alias Forum.Studios.Studio

IO.puts "Attempting to create studio..."
changeset = Studio.changeset(%Studio{}, %{name: "Universal Pictures"})
case Repo.insert(changeset) do
  {:ok, studio} -> IO.inspect(studio, label: "Success")
  {:error, changeset} -> IO.inspect(changeset, label: "Error")
end
