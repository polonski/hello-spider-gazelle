require "clear"

class Tasks < Application
  base "/"

  options "/" do
    response.headers["Access-Control-Allow-Methods"] = "GET,HEAD,POST,DELETE,OPTIONS,PUT,PATCH"
  end

  options "/:id" do
    response.headers["Access-Control-Allow-Methods"] = "GET,HEAD,POST,DELETE,OPTIONS,PUT,PATCH"
  end

  # before_action :find_task
  # getter task : Task?

  def index
    # all_tasks=nil
    begin
      all_tasks = Task.query.select.to_a
      render text: all_tasks.to_json
    rescue e
      raise e
    end
  end

  def show
    t : Task = Task.query.find({id: params["id"]}).as(Task)

    render text: t.to_json
  end

  def create
    # for some reason if this hash is not passed into a variable
    # and directly placed inside Task.new() , it gived this err:
    # Unexpected token: <EOF> at 1:1 (JSON::ParseException)
    h = JSON.parse(request.body.as(IO))

    t : Task? = Task.new(h)

    t.save
    t.url = "https://#{request.headers["host"]}/#{t.id}"

    # runs model validate and produces Clear::Model::InvalidError if not valid
    t.save!

    render text: t.to_json
  end

  delete "/" do
    # wrath of god
    render text: Task.query.select.to_delete.execute
  end

  def destroy
    d = Task.query.select({id: params["id"]}).to_delete.execute

    raise
    render text: ""
  end

  def update
    t : Task = Task.query.find({id: params["id"]}).as(Task)

    h = JSON.parse(request.body.as(IO)).as_h

    t.title = h["title"].to_s if h.has_key?("title")
    t.order = h["order"].to_s.to_i if h.has_key?("order")

    t.completed = true if h.has_key?("completed")
    t.save!

    render text: t.to_json
  end
end
