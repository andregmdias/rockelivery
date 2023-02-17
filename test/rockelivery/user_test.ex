defmodule Rockelivery.UserTest do
  alias Rockelivery.User

  describe "changeset/1" do
    test "when all params are valid, should return a valid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "31442561",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?} = User.changeset(params)

      assert valid_changeset?
    end

    test "when some required param is missing, should return an invalid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, errors: errors} = User.changeset(params)
      refute valid_changeset?
      assert errors == [cep: {"can't be blank", [validation: :required]}]
    end

    test "when the user has under 18 years, should return an invalid changeset" do
      params = %{
        age: 17,
        address: "Rua dos testes, 429",
        cep: "31442561",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, errors: errors} = User.changeset(params)

      refute valid_changeset?

      assert errors == [
               age:
                 {"must be greater than or equal to %{number}",
                  [validation: :number, kind: :greater_than_or_equal_to, number: 18]}
             ]
    end

    test "when the cpf param has a invalid length, should return an invalid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "31442561",
        cpf: "123123123",
        email: "johnreese@poi.com",
        password: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, errors: errors} = User.changeset(params)

      refute valid_changeset?

      assert errors == [
               cpf:
                 {"should be %{count} character(s)",
                  [count: 11, validation: :length, kind: :is, type: :string]}
             ]
    end

    test "when the cep param has a invalid length, should return an invalid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "314425",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password: "somesecretverysecret",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, errors: errors} = User.changeset(params)

      refute valid_changeset?

      assert errors == [
               cep:
                 {"should be %{count} character(s)",
                  [count: 8, validation: :length, kind: :is, type: :string]}
             ]
    end

    test "when the password param has an invalid length, should return an invalid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "12341234",
        cpf: "12312312311",
        email: "johnreese@poi.com",
        password: "short",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, errors: errors} = User.changeset(params)

      refute valid_changeset?

      assert errors == [
               password:
                 {"should be at least %{count} character(s)",
                  [count: 6, validation: :length, kind: :min, type: :string]}
             ]
    end

    test "when the email param has an invalid format, should return an invalid changeset" do
      params = %{
        age: 18,
        address: "Rua dos testes, 429",
        cep: "12341234",
        cpf: "12312312311",
        email: "poi.com",
        password: "shortpasss",
        name: "John Reese"
      }

      %Ecto.Changeset{valid?: valid_changeset?, errors: errors} = User.changeset(params)

      refute valid_changeset?

      assert errors == [{:email, {"has invalid format", [validation: :format]}}]
    end
  end
end
