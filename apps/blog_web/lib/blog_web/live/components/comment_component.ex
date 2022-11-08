defmodule BlogWeb.CommentComponent do
  use BlogWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="comment">
        <li><%= @comment.description %></li>
        <%= if @user_id == @comment.user_id do %>
        <button phx-click="comment-edit" phx-value-id={@comment.id} phx-value-post-id={@post_id}> Edit</button>
        <% end %>
      </div>
    """
  end
end
