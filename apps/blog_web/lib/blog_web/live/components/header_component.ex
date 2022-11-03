defmodule BlogWeb.HeaderComponent do
  use BlogWeb, :live_component

  def render(assigns) do
    ~H"""
    <header>
    <section class="container">
      <nav>
        <ul>
        <%= if @user_id do %>
          <li><a href="#" phx-click="logout"> Logout </a></li>
        <% else %>
          <li><a href="#" phx-click="open" phx-value-id="register-modal"> Register </a></li>
          <li><a href="#" phx-click="open" phx-value-id="login-modal"> Login </a></li>
        <% end %>
        </ul>
      </nav>
      <a href="https://phoenixframework.org/" class="phx-logo">
        <img src={Routes.static_path(@socket, "/images/phoenix.png")} alt="Phoenix Framework Logo"/>
      </a>
    </section>
    </header>
    """
  end
end
