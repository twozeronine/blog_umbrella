defmodule BlogWeb.PageLive do
  use BlogWeb, :live_view

  def mount(_params, _seission, socket) do
    {:ok, socket}
  end
end
