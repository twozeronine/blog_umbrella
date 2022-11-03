defmodule BlogWeb.PostsComponent do
  use BlogWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
    <h1> Listing Posts </h1>
    <%= if @user_id do %>
    <span><button phx-click="post_new"> Write </button></span>
    <% end %>
    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <%= for post <- @posts do %>
                <tr>
                    <td><%= post.title %></td>
                    <td><a href="#" phx-click="post_view" phx-value-id={post.id} >View</a></td>
                    <%= if post.user_id == @user_id do %>
                    <td><a href="#" phx-click="post_edit" phx-value-id={post.id} >Edit</a></td>
                    <% end %>
                </tr>
            <% end %>
        </tbody>
    </table>

    </div>
    """
  end
end
