defmodule NewsApp.FeedbackController do
  use NewsApp.Web, :controller
  alias NewsApp.{News, Repo, Feedback}

  def create_feedback(conn, params) do
  	changeset = Feedback.changeset(%Feedback{}, params)
  	case Repo.insert(changeset) do
      {:ok, _news}         -> conn |> send_resp(201, "success")
      {:error, _changeset} -> conn |> send_resp(400, "error")
    end
  end

end