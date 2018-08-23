require 'sinatra'
require 'sinatra/contrib'

# Allowed the server to be reloaded without having to close it down and restart it again
require 'sinatra/reloader' if development?
require 'pry'
require_relative './controllers/posts_controller.rb'



# Override methods
use Rack::Reloader
use Rack::MethodOverride

run PostsController
