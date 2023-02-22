defmodule Rockelivery.Users.Get do
  @moduledoc """
  Est módulo é responsável por buscas de usuários no banco de dados.
  """
  alias Ecto.UUID
  alias Rockelivery.{User, Repo}

  @doc """
  Esta função busca por um usário no banco filtrado pelo uuid informado.
  """
  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalid uuid !"}}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, result: "User not found!"}}
      %User{} = user -> {:ok, user}
    end
  end
end
