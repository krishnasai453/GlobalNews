defmodule NewsApp.SubscriptionController do
  use NewsApp.Web, :controller
  alias NewsApp.{News, Repo, Subscription}

  def create_subscription(conn, params) do
  	changeset = Subscription.changeset(%Subscription{}, params)
  	case Repo.insert(changeset) do
      {:ok, _news}         -> conn |> send_resp(201, "success")
      {:error, _changeset} -> conn |> send_resp(400, "error")
    end
  end

end
