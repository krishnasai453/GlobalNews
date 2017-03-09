defmodule NewsApp.Subscription do
  use NewsApp.Web, :model
  import Ecto.Query
  alias NewsApp.{Repo, Parsers}

  schema "subscription" do
    field :email,          	   :string, primary_key: true
    field :type,      	       :string
    field :is_verified_user,   :string
    field :inserted_at,        :string, default: Parsers.now()
    field :updated_at,         :string, default: Parsers.now()
  end

@required_fields ~w(email type is_verified_user)
@optional_fields ~w(inserted_at updated_at)

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