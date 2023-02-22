defmodule RockeliveryWeb.UserController do
  use RockeliveryWeb, :controller

  alias RockeliveryWeb.FallbackController
  alias Rockelivery.User

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = created} <- Rockelivery.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: created)
    end
  end
end
