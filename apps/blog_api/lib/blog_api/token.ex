defmodule BlogApi.Token do
  use Joken.Config

  def generate_token(user_id) do
    signer = create_signer()

    case __MODULE__.generate_and_sign(%{"user_id" => user_id}, signer) do
      {:ok, token, _claims} -> token
      {:error, reason} -> {:error, reason}
    end
  end

  def verify_token(token_string) do
    signer = create_signer()

    {:ok, token} = __MODULE__.verify(token_string, signer)
    token
  end

  def validate_token(token) do
    {:ok, user_id} = __MODULE__.validate(token, token)
    user_id
  end

  def create_signer() do
    {:ok, signer} = Application.fetch_env(:joken, :default_signer)
    Joken.Signer.create("HS256", signer)
  end
end
