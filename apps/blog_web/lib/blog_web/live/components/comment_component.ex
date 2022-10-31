defmodule BlogWeb.CommentComponent do
  use BlogWeb, :live_component

  def render(assigns) do
    ~H"""
    <li>
    <%= @description %>
    </li>
    """
  end
end
