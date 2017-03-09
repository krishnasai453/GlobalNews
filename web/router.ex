defmodule NewsApp.Router do
  use NewsApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NewsApp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", NewsApp do
  #   pipe_through :api
  # end
  #
  scope "/", NewsApp do
    pipe_through :api
    get     "/news/top",                  NewsController,           :top_news
    get     "/news/latest",               NewsController,           :latest_news
    get     "/source",                    SourceController,         :get_sources
    post    "/feedback",                  FeedbackController,         :create_feedback
    post    "/subscription",              SubscriptionController,   :create_subscription
  end
end
