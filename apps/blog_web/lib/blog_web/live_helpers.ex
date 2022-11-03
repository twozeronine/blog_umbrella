defmodule BlogWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  def modal(assigns) do
    ~H"""
    <div class="phx-modal"}>
      <div
        class="phx-modal-content"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
          <a id="close" href="#" class="phx-modal-close" phx-click="close" phx-value-id={@modal_id} >✖</a>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
