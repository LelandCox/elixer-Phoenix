defmodule Forum.ProducersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forum.Producers` context.
  """

  @doc """
  Generate a producer.
  """
  def producer_fixture(attrs \\ %{}) do
    {:ok, producer} =
      attrs
      |> Enum.into(%{
        financing: true,
        name: "some name"
      })
      |> Forum.Producers.create_producer()

    producer
  end
end
