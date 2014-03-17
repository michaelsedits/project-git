require 'pry'
require 'active_record'
require 'logger'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'

class System < Sinatra::Base
  get "/" do
    @past_semesters = Semester.where('current = ?', 'f')
    
    @klasses = Klass.where('semester_id.current = ?', 't')
  end
  
  get "class/add" do
    
  end
end