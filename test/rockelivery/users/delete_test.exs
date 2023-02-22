defmodule Rockelivery.DeleteTest do
  use Rockelivery.DataCase, async: true
  import Rockelivery.Factory

  alias Rockelivery.Users.Delete

  describe "call/1" do
    test "deletes the user with the given id with success" do
      insert(:user)
      user = insert(:user, id: "6d97037c-ce00-455e-ad14-8ee53e212193")

      {:ok, deleted} = Delete.call(user.id)

      assert deleted.id == user.id
      assert deleted.cpf == user.cpf
      assert deleted.cep == user.cep
      assert deleted.address == user.address
      assert deleted.email == user.email
      assert deleted.age == user.age
    end

    test "when the user is not found with the given uuid" do
      insert(:user)

      {:error, %{status: status, result: result}} = Delete.call(Ecto.UUID.generate())

      assert status == :not_found
      assert result == "User not found!"
    end

    test "when the id has an invalid format" do
      {:error, %{status: status, result: result}} = Delete.call("123-213sa")

      assert status == :bad_request
      assert result == "Invalid uuid !"
    end
  end
end
