defmodule BlogDomain.Repo do
  use Ecto.Repo,
    otp_app: :blog_domain,
    adapter: Ecto.Adapters.Postgres

  @otp_app :blog_domain

  def migrate() do
    try do
      path = Application.app_dir(@otp_app, Application.get_env(@otp_app, __MODULE__)[:priv])
      versions = Ecto.Migrator.run(__MODULE__, path, :up, all: true)
      {:ok, versions}
    rescue
      exception ->
        {:error, Exception.format(:error, exception, __STACKTRACE__)}
    end
  end
end
