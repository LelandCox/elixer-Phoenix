defmodule Forum.ExecutivesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forum.Executives` context.
  """

  @doc """
  Generate a executive.
  """
  def executive_fixture(attrs \\ %{}) do
    {:ok, executive} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Forum.Executives.create_executive()

    executive
  end
end
