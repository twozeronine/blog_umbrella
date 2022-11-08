defmodule BlogWeb.LoginFormComponent do
  use BlogWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
      <div>
          <.form let={f} for={@user_changeset}
              phx-change="login_validate_check"
              phx-submit="login" >

          <%= label f, :user_email %>
          <%= email_input f, :user_email, required: true %>
          <%= error_tag f, :user_email %>

          <%= label f, :password %>
          <%= password_input f, :password, required: true%>
          <%= error_tag f, :password %>

          <%= submit "login" %>
        </.form>
      </div>
    """
  end
end
