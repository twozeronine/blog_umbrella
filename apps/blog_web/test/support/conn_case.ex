defmodule BlogWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import BlogWeb.ConnCase

      alias BlogWeb.Router.Helpers, as: Routes

      @endpoint BlogWeb.Endpoint
    end
  end

  setup _tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end