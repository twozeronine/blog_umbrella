defmodule BlogApi.Token do
  use Joken.Config

  def token_create() do
    {:ok, signer} = Application.fetch_env(:joken, :default_signer)
    Joken.Signer.create("HS256", signer)
  end
end
