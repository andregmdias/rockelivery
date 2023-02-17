defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase

  alias Rockelivery.User

  describe "changeset/1" do
    test "when all params are valid, should return a valid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "31442561",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password_hash: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, changes: changes} = User.changeset(params)
      assert valid_changeset?
      assert params == changes
    end

    test "when all the user has under 18 years, should return an invalid changeset" do
      params = %{
        age: 17,
        address: "Rua dos testes, 429",
        cep: "31442561",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password_hash: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, changes: changes, errors: errors} =
        User.changeset(params)

      refute valid_changeset?
      assert params == changes

      assert errors == [
               age:
                 {"must be greater than or equal to %{number}",
                  [validation: :number, kind: :greater_than_or_equal_to, number: 18]}
             ]
    end

    test "when all the cpf param has a invalid length, should return an invalid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "31442561",
        cpf: "123123123",
        email: "johnreese@poi.com",
        password_hash: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, changes: changes, errors: errors} =
        User.changeset(params)

      refute valid_changeset?
      assert params == changes

      assert errors == [
               cpf:
                 {"should be %{count} character(s)",
                  [count: 11, validation: :length, kind: :is, type: :string]}
             ]
    end

    test "when all the cep param has a invalid length, should return an invalid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "314425",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password_hash: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, changes: changes, errors: errors} =
        User.changeset(params)

      refute valid_changeset?
      assert params == changes

      assert errors == [
               cep:
                 {"should be %{count} character(s)",
                  [count: 8, validation: :length, kind: :is, type: :string]}
             ]
    end

    test "when all the password_hash param has a invalid length, should return an invalid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "12341234",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password_hash: "short",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, changes: changes, errors: errors} =
        User.changeset(params)

      refute valid_changeset?
      assert params == changes

      assert errors == [
               password_hash:
                 {"should be at least %{count} character(s)",
                  [count: 6, validation: :length, kind: :min, type: :string]}
             ]
    end
  end
end
