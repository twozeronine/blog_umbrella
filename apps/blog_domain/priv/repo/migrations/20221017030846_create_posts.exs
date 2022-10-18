defmodule BlogDomain.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  @table "posts"

  def change() do
    create table(@table) do
      add(:title, :string, [{:null, false}])
      add(:description, :text)
      add(:user_id, references(:users, on_delete: :nothing))

      timestamps()
    end

    create index(@table, :user_id)
  end
end
