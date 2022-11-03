defmodule BlogWeb.PageLive do
  use BlogWeb, :live_view

  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User

  @impl true
  def mount(_params, _seission, socket) do
    # 변수
    socket =
      socket
      |> assign(%{user_id: nil, user_changeset: Accounts.change_user()})
      # 모달 제어
      |> assign(%{register_modal: false, login_modal: false})

    {:ok, socket}
  end

  @impl true
  def handle_event("register_validate_check", %{"user" => user_params}, socket) do
    {:noreply, assign(socket, %{user_changeset: Accounts.change_user(user_params)})}
  end

  def handle_event("login_validate_check", %{"user" => user_params}, socket) do
    {:noreply, assign(socket, %{user_changeset: Accounts.change_login_user(user_params)})}
  end

  def handle_event("register", %{"user" => user_params}, socket) do
    case Accounts.create_user(user_params) do
      {:ok, %User{id: user_id}} ->
        {:noreply,
         socket
         |> assign(%{user_id: user_id, register_modal: false})}
    end
  end

  def handle_event(
        "login",
        %{"user" => %{"user_email" => user_email, "password" => password}},
        socket
      ) do
    case Accounts.authenticate_by_username_and_pass(user_email, password) do
      {:ok, %User{id: user_id}} ->
        {:noreply,
         socket
         |> assign(%{user_id: user_id, login_modal: false})}
    end
  end

  def handle_event("open", %{"id" => "register-modal"}, socket) do
    {:noreply, assign(socket, %{register_modal: true})}
  end

  def handle_event("open", %{"id" => "login-modal"}, socket) do
    {:noreply, assign(socket, %{login_modal: true})}
  end

  def handle_event("close", %{"id" => "register-modal"}, socket) do
    {:noreply, assign(socket, %{register_modal: false})}
  end

  def handle_event("close", %{"id" => "login-modal"}, socket) do
    {:noreply, assign(socket, %{login_modal: false})}
  end
end
