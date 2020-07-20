class Task
    include Clear::Model
    
    column id : Int64, primary: true, presence: false
    column name : String
    column description : String?
    column done : Bool

end
