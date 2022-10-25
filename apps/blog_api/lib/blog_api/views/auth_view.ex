defmodule BlogApi.AuthView do
  use BlogApi, :view

  def render("show.json", %{user: user, token: token}) do
    %{
      data: %{
        user_name: user.user_name,
        user_email: user.user_email,
        token: token
      }
    }
  end
end
