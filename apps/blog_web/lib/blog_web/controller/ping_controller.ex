defmodule BlogApi.PingController do
  use BlogWeb, :controller

  def index(conn, _param) do
    text(conn, "pong")
  end
end
