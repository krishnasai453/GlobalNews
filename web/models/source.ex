defmodule NewsApp.Source do
  use NewsApp.Web, :model
  import Ecto.Query
  alias NewsApp.{Repo, Parsers}

  schema "sources" do
    field :source_id,          :string, primary_key: true
    field :name,      	       :string
    field :description,        :string
    field :url,                :string
    field :category,			     :string
    field :language,           :string
    field :country,            :string
    field :urlsToLogos,		     :map
    field :sortBysAvailable,   {:array, :string}, primary_key: true
    field :inserted_at,        :string, default: Parsers.now()
    field :updated_at,         :string, default: Parsers.now()
  end

@required_fields ~w(source_id name description sortBysAvailable category url)
@optional_fields ~w(country language urlsToLogos )

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:name)
  end

  def get_news_sources(scope \\ __MODULE__, sort_by) do
    from w in NewsApp.Source,
     where: w.sortBysAvailable == ^sort_by,
     select: w
  end
end
