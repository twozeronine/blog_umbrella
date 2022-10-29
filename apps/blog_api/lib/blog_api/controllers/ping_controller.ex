defmodule BlogApi.PingController do
  use BlogApi, :controller

  def index(conn, _param) do
    text(conn, "pong")
  end
end
