class Task
    
    include Clear::Migration

    def change(dir)

        Log.debug { "DEBUG: migrations direction: #{dir}" }
            
            
        #execute("CREATE TABLE tasks ( id serial NOT NULL PRIMARY KEY, name TEXT NOT NULL, description TEXT, done BOOLEAN);")

           create_table(:tasks) do |t|
           
                t.column :id, :bigint, primary: true
                t.column :name, :string, index: true
                t.column :description, :string, unique: true
                t.column :done, :boolean, unique: false

                t.index "lower(name || ' ' || description)", using: :btree

                t.timestamps
           end
    end
end