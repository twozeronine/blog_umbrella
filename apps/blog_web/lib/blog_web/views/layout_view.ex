defmodule BlogWeb.LayoutView do
  use BlogWeb, :view

  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
end
