defmodule Forum.StudiosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forum.Studios` context.
  """

  @doc """
  Generate a studio.
  """
  def studio_fixture(attrs \\ %{}) do
    {:ok, studio} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Forum.Studios.create_studio()

    studio
  end
end
