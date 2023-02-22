defmodule Rockelivery.CreateTest do
  use Rockelivery.DataCase, async: true
  import Rockelivery.Factory

  alias Rockelivery.Users.Create

  describe "call/1" do
    test "when params are valid" do
      user_params = params_for(:user)

      {:ok, created} = Create.call(user_params)

      assert created.address == user_params.address
      assert created.age == user_params.age
      assert created.name == user_params.name
      assert created.cep == user_params.cep
      assert created.cpf == user_params.cpf
      assert created.password == user_params.password
      assert created.email == user_params.email
    end

    test "when params are invalid" do
      user_params =
        params_for(:user,
          cpf: "123123123",
          cep: "123123",
          password: "short",
          email: "gmail.com",
          age: 17
        )

      {:error, changeset} = Create.call(user_params)

      assert changeset.errors == [
               email: {"has invalid format", [validation: :format]},
               age:
                 {"must be greater than or equal to %{number}",
                  [validation: :number, kind: :greater_than_or_equal_to, number: 18]},
               cpf:
                 {"should be %{count} character(s)",
                  [count: 11, validation: :length, kind: :is, type: :string]},
               cep:
                 {"should be %{count} character(s)",
                  [count: 8, validation: :length, kind: :is, type: :string]},
               password:
                 {"should be at least %{count} character(s)",
                  [count: 6, validation: :length, kind: :min, type: :string]}
             ]
    end

    test "when cpf already exists, should return an error" do
      insert(:user, cpf: "12312312311")
      user_params = params_for(:user, cpf: "12312312311")

      {:error, changeset} = Create.call(user_params)

      assert changeset.errors == [
               cpf:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "users_cpf_index"]}
             ]
    end

    test "when email already exists, should return an error" do
      insert(:user, email: "email@email.com", cpf: "32132132111")
      user_params = params_for(:user, email: "email@email.com")

      {:error, changeset} = Create.call(user_params)

      assert changeset.errors == [
               email:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "users_email_index"]}
             ]
    end
  end
end
