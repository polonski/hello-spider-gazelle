class Task
  include Clear::Migration

  def change(dir)
    puts "~~~~~~~~~~~~~~~~~~~~clear migration"

    dir.up do
      execute("CREATE TABLE tasks (id bigserial NOT NULL PRIMARY KEY, title text, completed boolean DEFAULT false, \"order\" integer, url text)")

      # create_table(:tasks) do |t|
      #   t.column :title, :string, index: true
      #   t.column :completed, :boolean, default: false
      #   t.column :order, :int32 #reserved keyword therefore must use SQL
      #   t.column :url, :string
      # end

    end
    dir.down do
      execute("DROP TABLE tasks")
    end
  end
end
