require "action-controller/logger"
require "secrets-env"

module App
  NAME    = "Spider-Gazelle"
  VERSION = {{ `shards version "#{__DIR__}"`.chomp.stringify.downcase }}

  Log         = ::Log.for(NAME)
  LOG_BACKEND = ActionController.default_backend

  ENVIRONMENT = ENV["SG_ENV"]? || "development"

  ENV["PG_DATABASE_URL"] = "postgresql://postgres:postgres@localhost/todo_tasks"

  # settings for heroku
 
  DEFAULT_PORT = ENV.has_key?("DATABASE_URL") ? 34464 : (ENV["SG_SERVER_PORT"]? || 3000).to_i
  DEFAULT_HOST = ENV.has_key?("DATABASE_URL") ? "0.0.0.0" : ENV["SG_SERVER_HOST"]? || "127.0.0.1"


  DEFAULT_PROCESS_COUNT = (ENV["SG_PROCESS_COUNT"]? || 1).to_i

  STATIC_FILE_PATH = ENV["PUBLIC_WWW_PATH"]? || "./www"

  COOKIE_SESSION_KEY    = ENV["COOKIE_SESSION_KEY"]? || "_spider_gazelle_"
  COOKIE_SESSION_SECRET = ENV["COOKIE_SESSION_SECRET"]? || "4f74c0b358d5bab4000dd3c75465dc2c"

  def self.running_in_production?
    ENVIRONMENT == "production"
  end
end
