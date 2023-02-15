Application.ensure_all_started(:mimic)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BlogDomain.Repo, :manual)
Mimic.copy(BlogDomain.Calculator)
