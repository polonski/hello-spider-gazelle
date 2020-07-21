require "clear"

class Tasks < Application

  base "/tasks"
  
  def index
     
    Log.debug { "GET /tasks" }

    tasks_title = "TO-DO-er"
    all_tasks = Task.query.to_a
   Log.debug { all_tasks.inspect }

    respond_with do     
      html template("tasks.ecr")
    end

  end


  def new
   
    Log.debug { "GET /tasks/new" }

    respond_with do
      html template("new_task.ecr")
    end

    # Clear::Migration::Manager.instance.apply_all

  end

  def create
      
      Log.debug { "GET /tasks#create" }

      #t = Task.new({name: "#{params["name"]}" })
      #t.description = "#{params["description"]}"
      #t.done = false
      #t.save!


      #begin
          Task.new({name: "#{params["name"]}", description: "#{params["description"]}", done: false  }).save!
      #rescue e
      #   respond_with do 
      #       json({error: "could not create new task. Message: #{e.message}"})
      #    end
      #else

          respond_with do 
             json({response: "new task created"})
          end
  
      #end

  
  end

  def destroy

      Log.debug { "DELETE /tasks/:id" }

      #Task.query.execute("DELETE FROM tasks WHERE tasks.id=#{params["id"]};")

      respond_with do 
        json({deleted_task: params["id"]})
      end

  end

  def update

      Log.debug { "PATCH /tasks/:id" }

      #Task.query.execute("UPDATE tasks  tasks.id=#{params["id"]};")

      respond_with do 
        json({updated_task: params["id"]})
      end
      
  end


end
