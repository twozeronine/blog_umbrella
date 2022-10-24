defmodule BlogApi.Token do
  use Joken.Config

  def token_create() do
    Joken.Signer.create("HS256", Application.fetch_env(:joken, :default_signer))
  end
end
