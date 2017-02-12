defmodule NewsApp.NewsView do
  use NewsApp.Web, :view

  def render("show.json", %{news: news}) do
    %{news: render_many(news, NewsApp.NewsView, "news.json")}
  end

  def render("news.json", %{news: news}) do
    %{
    source:        news.source,
    sort_by:       news.sort_by,
    author:       news.author,
    description:   news.description,
    published_at:  news.published_at,
    title:         news.title,
    url:           news.url,
    urlToImage:    news.urlToImage
    }
  end

  ### PRIVATE FUNCTIONS

end