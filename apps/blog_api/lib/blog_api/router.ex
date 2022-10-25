defmodule BlogApi.Router do
  use BlogApi, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BlogApi.AuthPlug
  end

  scope "/api/auth", BlogApi do
    pipe_through :auth

    get "/users", UserController, :index
    post "/posts", PostController, :create
    post "/posts/:post_id/comments", CommentController, :create
    put "/posts/:post_id/comments/:id", CommentController, :update
  end

  scope "/api", BlogApi do
    pipe_through :api

    resources "/users", UserController, only: [:show, :update]
    resources "/posts", PostController, only: [:index, :show, :update, :delete]

    resources "/posts/:post_id/comments", CommentController, only: [:index, :show, :delete]

    post "/register", AuthController, :register
    post "/login", AuthController, :login
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BlogApi.Telemetry
    end
  end
end
