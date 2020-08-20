class Task
  include Clear::Model

  # column id : Int64, primary: true, presence: false
  # column name : String
  # column description : String
  # column done : Bool

  column id : Int32, primary: true, presence: false

  column title : String
  column order : Int32?
  column url : String?
  column completed : Bool?

  self.table = "tasks"

  def validate
    if !title.nil?
      if title.size < 4
        add_error("title", "must contains at least 5 characters")
      end
      #
      #   end
      #   if !name_column.nil?
      #
      #     if name.size < 2
      #       add_error("name", "must contains at least 3 characters")
      #     end

    end
  end
end
