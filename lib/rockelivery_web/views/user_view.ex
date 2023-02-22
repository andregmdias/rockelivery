defmodule RockeliveryWeb.UserView do
  use RockeliveryWeb, :view

  def render("create.json", %{user: user}) do
    %{
      message: "User created",
      user: render_one(user, __MODULE__, "user.json")
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      age: user.age,
      address: user.address,
      cep: user.cep,
      cpf: user.cpf,
      email: user.email,
      name: user.name
    }
  end
end
