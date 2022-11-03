defmodule BlogWeb.PostComponent do
  use BlogWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <h2>Title : <%= @post.title %></h2>
      <hr>
      <h3><%= @post.description %></h3>
      <hr>
      <ul>
        <%= if @user_id do %>
        <button phx-click="comment_new" phx-value-post_id={@post.id}>Write Comment</button>
        <% end %>
        <%= for comment <- @post.comments do %>
          <.live_component module={BlogWeb.CommentComponent} id={comment.id} comment={comment} />
        <% end %>
      </ul>
    </div>
    """
  end
end
