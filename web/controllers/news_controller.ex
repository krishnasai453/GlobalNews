defmodule NewsApp.NewsController do
  use NewsApp.Web, :controller
  alias NewsApp.{News, Repo}
  @news_url "https://newsapi.org/v1/articles?source="
  @headers [{"Content-Type", "application/json"}]

  @news_source ["espn",
                "cnn",
                "bbc-news",
                "google-news"]
 
   @api_key "&apiKey=fd355360d8b246c8a811cd6c88e34bc9"

  def index(conn, _params) do
    render conn, "index.html"
  end


  def top_news(conn, _params) do
    IO.inspect "====top_news|| conn==="
    IO.inspect conn
    news = News.get_top_news |>  Repo.all
    # news = Repo.get(News, sort_by: :top) 
    IO.inspect "====top_news|| top_news==="
    IO.inspect news
    render(conn, "show.json", news: news)
  end

  def latest_news(conn, _params) do
    IO.inspect "====latest_news|| conn==="
    IO.inspect conn
    news = News.get_top_news |>  Repo.all
    # news = Repo.get(News, sort_by: :top) 
    IO.inspect "====latest_news|| top_news==="
    IO.inspect news
    render(conn, "show.json", news: news)
  end

  def cron_job() do
    news_source = getnews("&sortBy=top") |> List.flatten
    IO.inspect "====top_news|| news_source==="
    IO.inspect news_source
    Enum.map(news_source, fn(news) ->
    IO.inspect "====top_news|| news==="
    IO.inspect news
    changeset    = News.changeset(%News{}, news)
    IO.inspect "====top_news|| changeset==="
    IO.inspect changeset
    case Repo.insert(changeset) do
      {:ok, _news}         -> {:ok}
      {:error, _changeset} -> {:error}
      end
    end)
  end

  def http_request(url) do
    resp = HTTPoison.get!(url, @headers)
    decoded_resp = Poison.decode!(resp.body)
    IO.inspect "====resp==="
    IO.inspect decoded_resp
  end

## Private Functions


  defp getnews(sort_by) do
    Enum.map(@news_source, fn(source) -> 
    url = @news_url <> source <> sort_by <> @api_key
    IO.inspect "====result==="
    IO.inspect url
    resp = http_request(url)
    complete_articles = merge_map(resp)    
  end)
  end

  defp merge_map(%{"articles" => articles, "sortBy" => sortBy, 
                   "source" => source, "status" => status}) do

    Enum.map(articles, fn(full_article) -> 
        Map.merge(full_article, %{ "sort_by" => sortBy, "source" => source, "status" => status})
     end)

  end
  # defp create_map(news) do
  #   IO.inspect "====create_map|| news==="
  #   IO.inspect news
  # end
end

