defmodule BlogWeb.RegisterFormComponent do
  use BlogWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.form let={f} for={@user_changeset}
        phx-change="register_validate_check"
        phx-submit="register">

        <%= label f, :user_email %>
        <%= email_input f, :user_email, required: true %>
        <%= error_tag f, :user_email %>

        <%= label f, :user_name %>
        <%= text_input f, :user_name, required: true %>
        <%= error_tag f, :user_name %>

        <%= label f, :password %>
        <%= password_input f, :password, required: true ,value: input_value(f, :password) %>
        <%= error_tag f, :password %>

        <%= submit "Register" %>
      </.form>
    </div>
    """
  end
end
