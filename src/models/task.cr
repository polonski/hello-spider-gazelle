class Task
  include Clear::Model

  # column id : Int64, primary: true, presence: false
  # column name : String
  # column description : String
  # column done : Bool

  column id : Int32, primary: true, presence: false

  column title : String, column_name: "title"
  column completed : Bool?, column_name: "completed"
  column order : Int32?, column_name: "order"
  column url : String?, column_name: "url"

  self.table = "tasks"

  def validate
    #   if !description_column.nil?
    #
    #
    #     if description.size < 10
    #       add_error("description", "must contains at least 10 characters")
    #     end
    #
    #   end
    #   if !name_column.nil?
    #
    #     if name.size < 2
    #       add_error("name", "must contains at least 3 characters")
    #     end

    #  end
  end
end
