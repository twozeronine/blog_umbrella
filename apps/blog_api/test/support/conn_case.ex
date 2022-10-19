defmodule BlogApi.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import BlogApi.ConnCase

      alias BlogApi.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint BlogApi.Endpoint
    end
  end

  setup tags do
    BlogDomain.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
