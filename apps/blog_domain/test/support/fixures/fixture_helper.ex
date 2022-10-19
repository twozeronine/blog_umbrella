defmodule BlogDomain.FixtureHelper do
  alias BlogDomain.{Accounts, Boards}

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

  def post_fixtrue(owner, attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        title: "title",
        description: "description"
      })
      |> then(fn params ->
        Boards.create_post(owner, params)
      end)

    post
  end
end
