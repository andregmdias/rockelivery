defmodule Rockelivery.GetTest do
  use Rockelivery.DataCase, async: true
  import Rockelivery.Factory

  alias Rockelivery.Users.Get

  describe "by_id/1" do
    test "when the user is found with the given uuid" do
      insert(:user)
      user = insert(:user, id: "6d97037c-ce00-455e-ad14-8ee53e212193")

      {:ok, fetched} = Get.by_id(user.id)

      assert fetched.id == user.id
      assert fetched.cpf == user.cpf
      assert fetched.cep == user.cep
      assert fetched.address == user.address
      assert fetched.email == user.email
      assert fetched.age == user.age
    end

    test "when user is not found with the given uuid" do
      insert(:user)

      {:error, %{status: status, result: result}} = Get.by_id(Ecto.UUID.generate())

      assert status == :not_found
      assert result == "User not found!"
    end

    test "when the id has an invalid format" do
      {:error, %{status: status, result: result}} = Get.by_id("123-213sa")

      assert status == :bad_request
      assert result == "Invalid uuid !"
    end
  end
end
