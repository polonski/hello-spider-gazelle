class Task
  include Clear::Migration

  def change(dir)
    Log.debug { "DEBUG: migrations direction: #{dir}" }

    # execute("CREATE TABLE tasks ( id serial NOT NULL PRIMARY KEY, name TEXT NOT NULL, description TEXT, done BOOLEAN);")
#Clear::SQL.init(App::POSTGRES_DATABASE, connection_pool_size: 5)
    create_table(:tasks) do |t|
      #t.column :id, :bigint, index: true
      t.column :name, :string
      t.column :description, :string, unique: true
      t.column :done, :boolean

      t.index "lower(name || ' ' || description)", using: :btree

      t.timestamps
    end
  end
end
