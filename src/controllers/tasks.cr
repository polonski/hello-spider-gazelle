require "clear"

class Tasks < Application
  base "/tasks"

  def index
    Log.debug { "GET /tasks" }
    tasks_title = "TO-DO-er"
    begin
      all_tasks = Task.query.to_a
      # Clear::Migration::Manager.instance.apply_all

    rescue e
      respond_with do
        json({error: " Could not read data. Message: #{e.message}"})
      end
    else
      respond_with do
        html template("tasks.ecr")
      end
    end
  end

  def new
    Log.debug { "GET /tasks/new" }

    respond_with do
      html template("new_task.ecr")
    end
  end

  def create
    Log.debug { "POST /tasks#create" }

    t = Task.new({
      name:        "#{params["name"]}",
      description: "#{params["description"]}",
      done:        false,
    })

    # run validate method inside the clear model
    if t.valid?
      t.save!
      redirect_to Tasks.index
    else
      respond_with do
        html template("create_error.ecr")
      end
    end
  end

  def destroy
    Log.debug { "DELETE /tasks/:id" }

    begin
      # Clear::SQL.execute("DELETE FROM tasks WHERE tasks.id=#{params["id"]};")

      Task.query.where { id == params["id"] }.to_delete.execute
    rescue e
      respond_with do
        json({error: " Could not delete task. Message: #{e.message}"})
      end
    else
      respond_with do
        json({deleted_task: params["id"]})
      end
    end
  end

  def update
    Log.debug { "PATCH /tasks/:id >> /tasks#update" }

    # Clear::SQL.execute("UPDATE tasks SET tasks.name=#{params["name"]} tasks.description=#{params["description"]} tasks.done=#{params["done"]} WHERE tasks.id=#{params["id"]};")

    begin
        Task.query.where { id == params["id"] }
                  .to_update
                  .set( Hash(String, String).from_json(request.body.as(IO)) )
                  .execute
    rescue e
      respond_with do
        json({error: " Could not update task. Message: #{e.message}"})
      end
    else
      respond_with do
        json({updated_task: params["id"]})
      end
    end
  end

  def replace
  end


  patch "/:id/toggle_status", :status do
    
  end


  get "/:id/status", :status do

    Log.debug { "GET /:id/toggle_status >> /tasks#toggle_status(#{params.inspect})" }
    begin
      task = Task.query.where { id == params["id"] }
      s = false
      task.each do |t|
        s = t.done
      end

    rescue e
      raise Exception.new "could not fetch task #{params["id"]}"
    else
      respond_with do
        json({status: s})
      end
    end
  end

end
