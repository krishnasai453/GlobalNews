defmodule NewsApp.SourceController do
  use NewsApp.Web, :controller
  alias NewsApp.{Source, Repo}

  def get_sources(conn, _params) do
    url = "https://newsapi.org/v1/sources?apiKey=fd355360d8b246c8a811cd6c88e34bc9"
    sources = CronJobHandler.http_request(url)
    Enum.map(sources["sources"], fn(source) ->
    source_id = source["id"]
    changeset    = Source.changeset(%Source{}, Map.merge(source, %{"source_id" => source_id}))
    case Repo.insert(changeset) do
      {:ok, _news}         -> conn |> send_resp(201, "success")
      {:error, _changeset} -> conn |> send_resp(400, "error")
      end
    end)
  end
end
