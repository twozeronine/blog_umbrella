defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BlogWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", BlogWeb do
    pipe_through :browser

    live_session :default do
      live "/", PageLive
      live "/posts", PostsLive
      live "/posts/:id", PostsLive, :show
    end

    live_session :users do
      live "/register", UsersLive, :register
      live "/login", UsersLive, :login
      live "/users/:user_id/posts", UsersLive, :show
      live "/users/:user_id/posts/new", UsersLive, :post_new
      live "/users/:user_id/posts/:post_id", UsersLive, :post_show
      live "/users/:user_id/posts/:post_id/comments/new", UsersLive, :comments_new
    end
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BlogWeb.Telemetry
    end
  end
end
