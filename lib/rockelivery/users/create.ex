defmodule Rockelivery.Users.Create do
  @moduledoc """
  Est módulo é responsável por gerenciar a inserção de novos
  usuários no banco de dados.
  """
  alias Rockelivery.{User, Repo}

  @doc """
  Esta função insere um novo usuário no banco de dados.
  """
  @spec call(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
