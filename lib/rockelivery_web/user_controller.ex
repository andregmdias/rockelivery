defmodule RockeliveryWeb.UserController do
  use RockeliveryWeb, :controller

  alias RockeliveryWeb.ErrorView
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

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Rockelivery.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end
end
