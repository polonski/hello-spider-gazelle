require "clear"

class Tasks < Application

  base "/tasks"
  
  def index
     
    Log.debug { "GET /tasks" }

    tasks_title = "TO-DO-er"
    all_tasks = Task.query.to_a

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
      
      Log.debug { "POST /tasks#create" }

      begin
          Task.new({
                    name: "#{params["name"]}", 
                    description: "#{params["description"]}", 
                    done: false  
                    }).save!
      rescue e
         respond_with do 
             json({error: "could not create new task. Message: #{e.message}"})
          end
      else

        redirect_to Tasks.index()
  
      end
      
  
  end

  def destroy
    
    Log.debug { "DELETE /tasks/:id" }
    
    begin
    
      #Clear::SQL.execute("DELETE FROM tasks WHERE tasks.id=#{params["id"]};")
    
      Task.query.where{ id == params["id"] }.to_delete.execute

    rescue e

      respond_with do 
        json({error: "could not delete task. Message: #{e.message}"})
      end

    else
      
      respond_with do 
        json({deleted_task: params["id"]})
      end

    end

  end

  def update

      Log.debug { "PATCH /tasks/:id >> /tasks#update" }

      #Clear::SQL.execute("UPDATE tasks SET tasks.name=#{params["name"]} tasks.description=#{params["description"]} tasks.done=#{params["done"]} WHERE tasks.id=#{params["id"]};")

      if params["done"]
        redirect_to Tasks.status_change(id: params["id"].to_i,done: params["done"])
      end

      Task.query.where{ id == params["id"] }.
                to_update.set(name: Clear::SQL.unsafe(params["name"])).execute

     
      respond_with do 
        json({updated_task: params["id"]})
      end
      
  end

  def show

  end


  get "/:id/status", :status do

    Log.debug { "GET /:id/status >> /tasks#status(#{params.inspect})" }

    task = Task.query.where{ id == params["id"] }

    s = false

    task.each do |t|
      s = t.done
    end

    respond_with do 
        json({status: s})
    end

  end




  post "/:id/status_change", :status_change do

    Log.debug { "PUT /:id/status_change >> /tasks#status_change(#{params.inspect})" }

    Task.query.where{ id == params["id"] }.
                to_update.set(done: params["done"]).execute


    redirect_to Tasks.status(id: params["id"].to_i)

  end

end
