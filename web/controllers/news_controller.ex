defmodule NewsApp.NewsController do
  use NewsApp.Web, :controller
  alias NewsApp.{News, Repo}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def top_news(conn, _params) do
    news = News.get_top_news |>  Repo.all
    render(conn, "show.json", news: news)
  end

  def latest_news(conn, _params) do
    news = News.get_latest_news |>  Repo.all
    render(conn, "show.json", news: news)
  end
end
