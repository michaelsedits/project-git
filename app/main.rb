require 'pry'
require 'active_record'
require 'logger'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'

class System < Sinatra::Base
  
  # Class for Klass
  get "/class/:id" do
    @klass = Klass.find(params[:id])
    @grade = Grade.where({:klass_id => params[:id]})
    
    erb :class
  end
  
  
  
end