require "./spec_helper"

describe Tasks do
  # ==============
  #  Unit Testing
  # ==============
  it "should generate a date string" do
    # instantiate the controller you wish to unit test
    tasks = Tasks.new(context("GET", "/tasks"))

    # Test the instance methods of the controller
    tasks.set_date_header.should contain("GMT")
  end

  it "should be valid" do
    pg_db = Clear::SQL.init("postgres://dev:PlaceOS321@localhost/todo_tasks", 
    connection_pool_size: 5)
    all_tasks = Task.query.to_a
    all_tasks.each do |t| t.valid? end
  end

  # ==============
  # Test Responses
  # ==============
  with_server do
    it "should tasks you" do
      result = curl("GET", "/tasks")
     # result.body.includes?("TODOer").should eq(true)
      #result.headers["Date"]?.nil?.should eq(false)
    end
  end
end
