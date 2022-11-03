defmodule BlogWeb.CommentComponent do
  use BlogWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <li><%= @comment.description %></li>
      </div>
    """
  end
end
