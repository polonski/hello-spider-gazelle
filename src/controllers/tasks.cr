require "clear"

class Tasks < Application
  base "/tasks"
  before_action :find_task

  def index
    Log.debug { "GET /tasks" }
    tasks_title = "TO-DO-er"
    begin
      all_tasks = Task.query.to_a
    rescue e
      raise Exception.new(" Exception from GET /tasks. Message: #{e.message}")
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
      raise Exception.new(" Exception from PATCH /tasks/:id. Message: #{e.message}")
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
      t : Task = Task.query.find({id: params["id"]}).as(Task)

      Clear::SQL.transaction do
        Hash(String, String).from_json(request.body.as(IO)).each do |k, v|
          t.name = v if k == "name"
          t.description = v if k == "description"
        end

        t.save! if t.valid?
      end
    rescue e
      raise e
    else
      respond_with do
        json({updated_task: params["id"]})
      end
    end
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
      raise Exception.new(" Exception from GET /:id/toggle_status. Message: #{e.message}")
    else
      respond_with do
        json({status: s})
      end
    end
  end

  def find_task
    Task.find!(params["id"])
  end
end
