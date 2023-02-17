defmodule Rockelivery.User do
  @moduledoc """
  Representa o schema da tabela users
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(age address cep cpf email password_hash name)a

  schema "users" do
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password_hash, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
  end
end
