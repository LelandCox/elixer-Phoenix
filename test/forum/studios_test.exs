defmodule Forum.StudiosTest do
  use Forum.DataCase

  alias Forum.Studios

  describe "studios" do
    alias Forum.Studios.Studio

    import Forum.StudiosFixtures

    @invalid_attrs %{name: nil}

    test "list_studios/0 returns all studios" do
      studio = studio_fixture()
      assert Studios.list_studios() == [studio]
    end

    test "get_studio!/1 returns the studio with given id" do
      studio = studio_fixture()
      assert Studios.get_studio!(studio.id) == studio
    end

    test "create_studio/1 with valid data creates a studio" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Studio{} = studio} = Studios.create_studio(valid_attrs)
      assert studio.name == "some name"
    end

    test "create_studio/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Studios.create_studio(@invalid_attrs)
    end

    test "update_studio/2 with valid data updates the studio" do
      studio = studio_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Studio{} = studio} = Studios.update_studio(studio, update_attrs)
      assert studio.name == "some updated name"
    end

    test "update_studio/2 with invalid data returns error changeset" do
      studio = studio_fixture()
      assert {:error, %Ecto.Changeset{}} = Studios.update_studio(studio, @invalid_attrs)
      assert studio == Studios.get_studio!(studio.id)
    end

    test "delete_studio/1 deletes the studio" do
      studio = studio_fixture()
      assert {:ok, %Studio{}} = Studios.delete_studio(studio)
      assert_raise Ecto.NoResultsError, fn -> Studios.get_studio!(studio.id) end
    end

    test "change_studio/1 returns a studio changeset" do
      studio = studio_fixture()
      assert %Ecto.Changeset{} = Studios.change_studio(studio)
    end
  end
end
