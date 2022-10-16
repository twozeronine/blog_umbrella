defmodule BlogDomain.Repo do
  use Ecto.Repo,
    otp_app: :blog_domain,
    adapter: Ecto.Adapters.Postgres
end
