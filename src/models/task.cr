class Task
  include Clear::Model

  column id : Int64, primary: true, presence: false
  column name : String
  column description : String
  column done : Bool

  def validate
    if !description_column.nil?
      # if description

      if description.size < 10
        add_error("description", "must contains at least 10 characters")
      end
      # end
    end
    if !name_column.nil?
      # if name
      if name.size < 2
        add_error("name", "must contains at least 3 characters")
      end
      # end
    end
  end

  # def update(vars : Hash)

  # vars.each do |k,v|
  #   name = v if k == "name"
  #  end

  # Hash(String, String).from_json( body.as(IO) )
  #   save!
  # Hash(String, String).from_json( body.as(IO) ).each  do |k,v|
  # t.name = "TEST" if t.name
  # puts "!@!@!@"
  #  puts k+" <> "+v
  # end

  #   end
end
