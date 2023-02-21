defmodule Rockelivery.User do
  @moduledoc """
  Representa o schema da tabela users
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(age address cep cpf email password name)a

  @type t :: %__MODULE__{
          id: binary(),
          age: String.t(),
          address: String.t(),
          cep: String.t(),
          cpf: String.t(),
          email: String.t(),
          password: String.t(),
          password: String.t(),
          name: String.t()
        }

  schema "users" do
    field(:age, :integer)
    field(:address, :string)
    field(:cep, :string)
    field(:cpf, :string)
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:name, :string)

    timestamps()
  end

  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{passwod: password}} = changeset) do
    change(changeset, %{password_hash: Pbkdf2.add_hash(password)})
  end

  defp put_password_hash(changeset), do: changeset
end
