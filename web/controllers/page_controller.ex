defmodule NewsApp.PageController do
  use NewsApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
