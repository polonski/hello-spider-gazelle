class Task
  include Clear::Migration

  def change(dir)
    Log.info { "INFO: migrations direction: #{dir}" }

    create_table(:tasks) do |t|
      t.column :name, :string
      t.column :description, :string, unique: true
      t.column :done, :boolean
      t.index "lower(name || ' ' || description)", using: :btree
      t.timestamps
    end
  end
end
