defmodule BlogWeb.PostFormComponent do
  use BlogWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <.form let={f} for={@changeset}>
          <%= if @live_action == :post_new do %>
            <%= label f, :title %>
            <%= text_input f, :title %>
            <%= error_tag f, :title %>
          <% end %>

          <%= label f, :description %>
          <%= text_input f, :description %>
          <%= error_tag f, :description %>
        </.form>
      </div>
    """
  end
end
