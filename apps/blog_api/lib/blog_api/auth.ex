defmodule BlogApi.Auth do
  alias BlogDomain.Accounts.User

  def get_token(%User{id: user_id}) do
    {:ok, invalid_token, _claims} = Blog.Token.generate_and_sign(%{"user_id" => user_id})

    invalid_token
  end
end
