defmodule NewsApp.CronJobHandler do
  alias NewsApp.{News, Repo, Source}

  @news_url "https://newsapi.org/v1/articles"
  @headers [{"Content-Type", "application/json"}]
  @api_key "fd355360d8b246c8a811cd6c88e34bc9"

  def cron_job do
    news_sources    = Source |> Repo.all |> List.flatten
    Enum.map(news_sources, fn(each_source) ->
      case each_source.sortBysAvailable do
        ["top"]           -> getnews(each_source.source_id ,"top")    |> store_in_db
        ["latest"]        -> getnews(each_source.source_id ,"latest") |> store_in_db
        ["top", "latest"] -> getnews(each_source.source_id ,"top")    |> store_in_db
                             getnews(each_source.source_id ,"latest") |> store_in_db
        ["latest", "top"] -> getnews(each_source.source_id ,"top")    |> store_in_db
                             getnews(each_source.source_id ,"latest") |> store_in_db
      end
    end)
  end

  def http_request(url) do
    resp = HTTPoison.get!(url, @headers)
    Poison.decode!(resp.body)
  end

## Private Functions

  defp store_in_db(news) do
    Enum.map(news, fn(each_article) ->
      changeset    = News.changeset(%News{}, each_article)
      case Repo.insert(changeset) do
        {:ok, _news}         -> {:ok}
        {:error, _changeset} -> {:error}
        end
    end)
  end

  defp getnews(source, sort_by) do
    url = @news_url <> "?source=" <> source <> "&sortBy=" <> sort_by <> "&apiKey=" <> @api_key
    http_request(url) |> merge_map
  end

  defp merge_map(%{"articles" => articles, "sortBy" => sortBy,
                   "source" => source, "status" => status}) do
    Enum.map(articles, fn(full_article) ->
        Map.merge(full_article, %{"sort_by" => sortBy, "source" => source, "status" => status})
    end)
  end
end
