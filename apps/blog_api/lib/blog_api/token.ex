defmodule BlogApi.Token do
  use Joken.Config

  def generate_and_sign_token(user_id) do
    singer = signer_create()

    case __MODULE__.generate_and_sign(%{"user_id" => user_id}, singer) do
      {:ok, token, _claims} -> token
      {:error, reason} -> {:error, reason}
    end
  end

  def verify_and_validate_token(authorization_header) do
    singer = signer_create()

    case authorization_header do
      [] ->
        nil

      bearer ->
        {:ok, %{"user_id" => user_id}} =
          bearer
          |> hd()
          |> String.split(" ")
          |> List.last()
          |> __MODULE__.verify_and_validate(singer)

        user_id
    end
  end

  defp signer_create() do
    {:ok, signer} = Application.fetch_env(:joken, :default_signer)
    Joken.Signer.create("HS256", signer)
  end
end
