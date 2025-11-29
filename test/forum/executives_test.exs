defmodule Forum.ExecutivesTest do
  use Forum.DataCase

  alias Forum.Executives

  describe "executives" do
    alias Forum.Executives.Executive

    import Forum.ExecutivesFixtures

    @invalid_attrs %{name: nil}

    test "list_executives/0 returns all executives" do
      executive = executive_fixture()
      assert Executives.list_executives() == [executive]
    end

    test "get_executive!/1 returns the executive with given id" do
      executive = executive_fixture()
      assert Executives.get_executive!(executive.id) == executive
    end

    test "create_executive/1 with valid data creates a executive" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Executive{} = executive} = Executives.create_executive(valid_attrs)
      assert executive.name == "some name"
    end

    test "create_executive/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Executives.create_executive(@invalid_attrs)
    end

    test "update_executive/2 with valid data updates the executive" do
      executive = executive_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Executive{} = executive} = Executives.update_executive(executive, update_attrs)
      assert executive.name == "some updated name"
    end

    test "update_executive/2 with invalid data returns error changeset" do
      executive = executive_fixture()
      assert {:error, %Ecto.Changeset{}} = Executives.update_executive(executive, @invalid_attrs)
      assert executive == Executives.get_executive!(executive.id)
    end

    test "delete_executive/1 deletes the executive" do
      executive = executive_fixture()
      assert {:ok, %Executive{}} = Executives.delete_executive(executive)
      assert_raise Ecto.NoResultsError, fn -> Executives.get_executive!(executive.id) end
    end

    test "change_executive/1 returns a executive changeset" do
      executive = executive_fixture()
      assert %Ecto.Changeset{} = Executives.change_executive(executive)
    end
  end
end
