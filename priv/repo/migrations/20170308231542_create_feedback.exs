defmodule NewsApp.Repo.Migrations.CreateFeedback do
  use Ecto.Migration

  def change do
    create table(:feedback, primary_key: false) do
      add :id,                 :uuid,  primary_key: true
      add :email,              :string, primary_key: true
      add :full_name,          :string
      add :phone,              :integer
      add :replied,            :string
      add :feedback,           :string
      add :inserted_at,        :string
      add :updated_at,         :string
  end
end
end
