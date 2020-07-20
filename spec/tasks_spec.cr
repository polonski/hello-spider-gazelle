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

  # ==============
  # Test Responses
  # ==============
  with_server do
    it "should tasks you" do
      result = curl("GET", "/task")
      result.body.includes?("TODOer").should eq(true)
      result.headers["Date"]?.nil?.should eq(false)
    end
  end
end
