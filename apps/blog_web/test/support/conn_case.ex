defmodule BlogWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import BlogWeb.ConnCase
      import BlogWeb.FixtureHelper

      alias BlogWeb.Router.Helpers, as: Routes

      @endpoint BlogWeb.Endpoint
    end
  end

  setup tags do
    BlogDomain.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
