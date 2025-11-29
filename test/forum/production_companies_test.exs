defmodule Forum.ProductionCompaniesTest do
  use Forum.DataCase

  alias Forum.ProductionCompanies

  describe "productioncompanies" do
    alias Forum.ProductionCompanies.ProductionCompany

    import Forum.ProductionCompaniesFixtures

    @invalid_attrs %{name: nil, financing: nil}

    test "list_productioncompanies/0 returns all productioncompanies" do
      production_company = production_company_fixture()
      assert ProductionCompanies.list_productioncompanies() == [production_company]
    end

    test "get_production_company!/1 returns the production_company with given id" do
      production_company = production_company_fixture()
      assert ProductionCompanies.get_production_company!(production_company.id) == production_company
    end

    test "create_production_company/1 with valid data creates a production_company" do
      valid_attrs = %{name: "some name", financing: true}

      assert {:ok, %ProductionCompany{} = production_company} = ProductionCompanies.create_production_company(valid_attrs)
      assert production_company.name == "some name"
      assert production_company.financing == true
    end

    test "create_production_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductionCompanies.create_production_company(@invalid_attrs)
    end

    test "update_production_company/2 with valid data updates the production_company" do
      production_company = production_company_fixture()
      update_attrs = %{name: "some updated name", financing: false}

      assert {:ok, %ProductionCompany{} = production_company} = ProductionCompanies.update_production_company(production_company, update_attrs)
      assert production_company.name == "some updated name"
      assert production_company.financing == false
    end

    test "update_production_company/2 with invalid data returns error changeset" do
      production_company = production_company_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductionCompanies.update_production_company(production_company, @invalid_attrs)
      assert production_company == ProductionCompanies.get_production_company!(production_company.id)
    end

    test "delete_production_company/1 deletes the production_company" do
      production_company = production_company_fixture()
      assert {:ok, %ProductionCompany{}} = ProductionCompanies.delete_production_company(production_company)
      assert_raise Ecto.NoResultsError, fn -> ProductionCompanies.get_production_company!(production_company.id) end
    end

    test "change_production_company/1 returns a production_company changeset" do
      production_company = production_company_fixture()
      assert %Ecto.Changeset{} = ProductionCompanies.change_production_company(production_company)
    end
  end
end
