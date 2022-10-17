defmodule BlogDomain.FixtureHelper do
  alias BlogDomain.{Accounts}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "Some User",
        username: "user#{System.unique_integer([:positive])}",
        password: attrs[:password] || "supersecret"
      })
      |> Accounts.create_user()

    user
  end
end
