defmodule Rockelivery.Users.Delete do
  @moduledoc """
  Est módulo é responsável por remover usuários do banco.
  """
  alias Ecto.UUID
  alias Rockelivery.{User, Repo}

  @doc """
  Esta função remove um usário no banco filtrado pelo uuid informado.
  """
  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalid uuid !"}}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, result: "User not found!"}}
      %User{} = user -> Repo.delete(user)
    end
  end
end
