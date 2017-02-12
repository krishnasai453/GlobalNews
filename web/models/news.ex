defmodule NewsApp.News do
  use NewsApp.Web, :model
  import Ecto.Query
  alias NewsApp.Repo

  schema "news" do
    field :source,      	:string
    field :sort_by,     	:string, primary_key: true
    field :author,			  :string
    field :description,  	:string
    field :published_at,	:string
    field :title,  			  :string
    field :url,       		:string
    field :urlToImage,		:string


    timestamps()
  end

@required_fields ~w(source sort_by author description title)
@optional_fields ~w(published_at url urlToImage)

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:title)
  end


  def get_top_news(scope \\ __MODULE__) do
    sort_by = "top"
    # scope |> where([u], ^sort_by in [u.sort_by])
    # Repo.all(NewsApp.News) |> where([u], ^sort_by in [u.sort_by])
    from w in NewsApp.News,
     where: w.sort_by == ^sort_by,
     select: w
  end
end