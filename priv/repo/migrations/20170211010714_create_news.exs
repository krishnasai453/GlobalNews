defmodule NewsApp.Repo.Migrations.CreateNews do
  use Ecto.Migration

  def change do
  	create table(:news, primary_key: false) do
      add :id,            :uuid,  primary_key: true
      add :source,        :string
      add :sort_by,       :string, primary_key: true
      add :author,        :string
      add :description,   :string
      add :published_at,  :string
      add :title,         :string
      add :url,           :string
      add :urlToImage,    :string

      timestamps
    end
   create unique_index(:news, [:title], unique: true)
  end
end
