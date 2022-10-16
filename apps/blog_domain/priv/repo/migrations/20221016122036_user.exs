defmodule BlogDomain.Repo.Migrations.User do
  use Ecto.Migration

  @table "users"

  def change do
    create table(@table) do
      add(:user_email, :string, [{:null, false}])
      add(:user_name, :string, [{:null, false}])
      add(:password_hash, :string, [{:null, false}])

      timestamps()
    end

    create(unique_index(@table, [:user_email]))
  end
end
