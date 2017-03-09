defmodule NewsApp.Repo.Migrations.CreateSource do
  use Ecto.Migration

    
def change do
    create table(:sources, primary_key: false) do
      add :id,                 :uuid,  primary_key: true
      add :source_id,          :string
      add :name,               :string, primary_key: true
      add :description,        :string
      add :url,                :string
      add :category,           :string
      add :language,           :string
      add :country,            :string
      add :urlsToLogos,        :map
      add :sortBysAvailable,   {:array, :string}, primary_key: true
      
      add :inserted_at,     :string
      add :updated_at,      :string
    end
   create unique_index(:sources, [:name], unique: true)
  end
end
