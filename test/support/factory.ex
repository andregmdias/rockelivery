defmodule Rockelivery.Factory do
  @moduledoc """
  Factory das entidades do Rockelivery
  """

  use ExMachina.Ecto, repo: Rockelivery.Repo

  def user_factory do
    %Rockelivery.User{
      age: Enum.random(18..80),
      address: sequence(:name, &"Rua #{&1}"),
      cep: "31442561",
      cpf: CPF.generate() |> to_string(),
      email: sequence(:name, &"name#{&1}@poi.com"),
      password: "somesecretverysecret",
      name: sequence(:name, &"Name #{&1}")
    }
  end
end
