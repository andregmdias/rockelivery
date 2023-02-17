defmodule Rockelivery.Factory do
  @moduledoc """
  Factory das entidades do Rockelivery
  """

  use ExMachina.Ecto, repo: Rockelivery.Repo

  def user_factory do
    %Rockelivery.User{
      age: 18,
      address: "Rua dos testes, 429",
      cep: "31442561",
      cpf: "12312312311",
      email: "johnreese@poi.com",
      password: "somesecretverysecret",
      name: "John Reese"
    }
  end
end
