defmodule BlogDomain.FixtureHelper do
  alias BlogDomain.{Accounts}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        user_email: "example@example.com#{System.unique_integer([:positive])}",
        user_name: "username",
        password: attrs[:password] || "supersecret"
      })
      |> Accounts.create_user()

    user
  end
end
