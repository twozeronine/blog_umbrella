defmodule BlogApi.UserController do
  use BlogApi, :controller

  def create(conn, params) do
    render(conn, "new.json")
  end

  def new(conn, params) do
    render(conn, "new.json")
  end
end
