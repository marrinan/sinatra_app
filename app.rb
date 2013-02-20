require 'sinatra'
require 'data_mapper'
require_relative 'pig_latin'

# Connects our Exercise class to the Sqlite3 database "app.db"
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")

# defines 'Exercise' class and various properties to be pulled by GET
class Exercise
    # Includes DataMapper resources 
    include DataMapper::Resource
    # Unique instance identifier, AKA: primary key
    property :id, Serial
    property :name, Text
    property :prompt, Text
    property :method_name, Text
    property :test, Text
end

# Automatically updates the database if the class or data structure changes
DataMapper.finalize.auto_upgrade!

# Uses HTTP 'get' method on the root "/" directory
get '/' do
  @exercise = Exercise.get params[:id]
# Calls the `erb` method and passes in the `:index` symbol, which is the name of our page
  erb :index
end

get '/:id' do
  @exercise = Exercise.get params[:id]
  erb :view
end

post '/' do
  exercise = Exercise.new
  exercise.name        = params[:name]
  exercise.prompt      = params[:prompt]
  exercise.method_name = params[:method_name]
  exercise.save
  redirect '/'  
end