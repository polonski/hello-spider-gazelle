require "./spec_helper"
require "secrets-env"

describe Tasks do
  # ==============
  #  Unit Testing
  # ==============
   Clear::SQL.init(App::POSTGRES_DATABASE, connection_pool_size: 5)

  it "should generate a date string" do
    # instantiate the controller you wish to unit test
    tasks = Tasks.new(context("GET", "/tasks"))

    # Test the instance methods of the controller
    tasks.set_date_header.should contain("GMT")
  end

  it "should contain data and not be empty" do
    Task.query.to_a.size.should_not eq eq(0)
  end

  it "in each database record should be valid" do
   
      # run the clear validation for each database record 
      Task.query.to_a.each do |t| 
        v = t.valid?
        puts "record #{t.id} is valid = #{v}" 
        v.should be_true
      end    
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
