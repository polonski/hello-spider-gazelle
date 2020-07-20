require "xml"

class Tasks < Application

  base "/tasks"

  def index
   
    tasks_title = "TODOer"
    Log.warn { "WARN: tasks" }
    Log.debug { "DEBUG: tasks index" }
    
 
    respond_with do
      
      #html template("tasks.ecr")
      
      #text "The #{tasks_title} app"
      
      json({title: tasks_title})
      
      xml do
        XML.build(indent: "  ") do |xml|
          xml.element("body") { xml.text tasks_title }
        end
      end
    end
  end


  def create
      
      Log.debug { "DEBUG: tasks create" }
      # apply all mirations from db/migrations
      Clear::Migration::Manager.instance.apply_all
  
  end

  def show; end



end
