defmodule NewsApp.Feedback do
  use NewsApp.Web, :model
  import Ecto.Query
  alias NewsApp.{Repo, Parsers}

  schema "feedback" do
    field :full_name,      	   :string
    field :email,              :string, primary_key: true
    field :phone,              :integer
    field :replied,            :string
    field :feedback,           :string
    field :inserted_at,        :string, default: Parsers.now()
    field :updated_at,         :string, default: Parsers.now()
  end

@required_fields ~w(email phone full_name feedback)
@optional_fields ~w(inserted_at updated_at replied)

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
  end

end