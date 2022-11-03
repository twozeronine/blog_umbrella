defmodule BlogWeb.CommentComponent do
  use BlogWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="comment">
        <li><%= @comment.description %></li>
        <button phx-click="comment-edit" phx-value-id={@comment.id}> Edit</button>
      </div>
    """
  end
end
