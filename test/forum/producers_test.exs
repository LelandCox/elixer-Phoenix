defmodule Forum.ProducersTest do
  use Forum.DataCase

  alias Forum.Producers

  describe "producers" do
    alias Forum.Producers.Producer

    import Forum.ProducersFixtures

    @invalid_attrs %{name: nil, financing: nil}

    test "list_producers/0 returns all producers" do
      producer = producer_fixture()
      assert Producers.list_producers() == [producer]
    end

    test "get_producer!/1 returns the producer with given id" do
      producer = producer_fixture()
      assert Producers.get_producer!(producer.id) == producer
    end

    test "create_producer/1 with valid data creates a producer" do
      valid_attrs = %{name: "some name", financing: true}

      assert {:ok, %Producer{} = producer} = Producers.create_producer(valid_attrs)
      assert producer.name == "some name"
      assert producer.financing == true
    end

    test "create_producer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Producers.create_producer(@invalid_attrs)
    end

    test "update_producer/2 with valid data updates the producer" do
      producer = producer_fixture()
      update_attrs = %{name: "some updated name", financing: false}

      assert {:ok, %Producer{} = producer} = Producers.update_producer(producer, update_attrs)
      assert producer.name == "some updated name"
      assert producer.financing == false
    end

    test "update_producer/2 with invalid data returns error changeset" do
      producer = producer_fixture()
      assert {:error, %Ecto.Changeset{}} = Producers.update_producer(producer, @invalid_attrs)
      assert producer == Producers.get_producer!(producer.id)
    end

    test "delete_producer/1 deletes the producer" do
      producer = producer_fixture()
      assert {:ok, %Producer{}} = Producers.delete_producer(producer)
      assert_raise Ecto.NoResultsError, fn -> Producers.get_producer!(producer.id) end
    end

    test "change_producer/1 returns a producer changeset" do
      producer = producer_fixture()
      assert %Ecto.Changeset{} = Producers.change_producer(producer)
    end
  end
end
