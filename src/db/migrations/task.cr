class Task
    
    include Clear::Migration

    def change(dir)
        create_table(:tasks) do |t|
           
            t.column :id, :bigint
            t.column :name, :string, index: true
            t.column :description, :string, unique: true
            t.column :done, :boolean, unique: true

            t.index "lower(name || ' ' || description)", using: :btree

            t.timestamps
        end
    end
end