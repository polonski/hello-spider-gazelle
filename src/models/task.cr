class Task
    include Clear::Model
    
    column id : Int64, primary: true, presence: false
    column name : String
    column description : String
    column done : Bool

    def validate
        if !description_column.nil?
            if description.size < 10
                add_error("description", "must contains at least 10 characters")
            end
        end
        if !name_column.nil?
            if name.size < 2
                add_error("name", "must contains at least 3 characters")
            end
        end
    end

end
