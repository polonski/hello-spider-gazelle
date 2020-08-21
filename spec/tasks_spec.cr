require "./spec_helper"
require "secrets-env"

describe Tasks do
  # ==============
  #  Unit Testing
  # ==============
  db_url = ENV.has_key?("DATABASE_URL") ? ENV["DATABASE_URL"] : ENV["PG_DATABASE_URL"]
  Clear::SQL.init(db_url, connection_pool_size: 5)

  it "should generate a date string" do
    # instantiate the controller you wish to unit test
    tasks = Tasks.new(context("GET", "/"))

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
      # puts "record #{t.id} is valid = #{v}"
      v.should be_true
    end
  end

  # ==============
  # Test Responses
  # ==============
  with_server do
    it " should get date" do
      result = curl("GET", "/")
      # result.success?.should be_true
      result.headers["Date"]?.nil?.should eq(false)
    end

    it " should contain CORS headers" do
      result = curl("GET", "/")
      result.headers["Access-Control-Allow-Origin"]?.nil?.should eq(false)
      result.headers["Access-Control-Allow-Headers"]?.nil?.should eq(false)
    end
  end
end
