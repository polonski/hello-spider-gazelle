require "clear"

class Tasks < Application
  base "/"

  options "/" do
    response.headers["Access-Control-Allow-Methods"] = "GET,HEAD,POST,DELETE,OPTIONS,PUT,PATCH"
  end

  options "/:id" do
    response.headers["Access-Control-Allow-Methods"] = "GET,HEAD,POST,DELETE,OPTIONS,PUT,PATCH"
  end

  def index
    render text: Task.query.select.to_a.to_json
  end

  def show
    render text: task(params["id"]).to_json
  end

  def create
    t : Task? = Task.new(JSON.parse(request.body.as(IO))).as(Task)
    t.save
    Clear::SQL.with_savepoint do
      t.url = "https://#{request.headers["host"]}/#{t.id}" # if t.id.created?
      t.save!
      Clear::SQL.rollback if !t.valid?
      Clear::SQL.with_savepoint do
        render text: t.to_json
      end
    end
  end

  delete "/" do
    # wrath of god
    render text: Task.query.select.to_delete.execute
  end

  def destroy
    Task.query.select({id: params["id"]}).to_delete.execute
    render text: ""
  end

  def update
    t : Task = task(params["id"])
    h = JSON.parse(request.body.as(IO)).as_h
    t.title = h["title"].to_s if h.has_key?("title")
    t.order = h["order"].to_s.to_i if h.has_key?("order")
    t.completed = true if h.has_key?("completed")
    t.save! if t.valid?
    render text: t.to_json
  end

  # helpers
  def task(id_in)
    Task.query.find({id: id_in}).as(Task)
  end
end
