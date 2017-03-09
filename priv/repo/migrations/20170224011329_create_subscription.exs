defmodule NewsApp.Repo.Migrations.CreateSubscription do
  use Ecto.Migration

  def change do
  	create table(:subscription, primary_key: false) do
      add :id,                 :uuid,  primary_key: true
      add :email,          	   :string, primary_key: true
      add :type,               :string
      add :is_verified_user,   :string
      add :inserted_at,        :string
      add :updated_at,         :string
    end
   create unique_index(:subscription, [:email], unique: true)
  end
end
