require 'pry'
require 'active_record'
require 'logger'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'

class System < Sinatra::Base
  get "/" do
    @klasses = Klass.where('semester_id.current = ?', 't')
    
    @past_semesters = Semester.where('current = ?', 'f')
    erb :home
  end
  
  get "class/add" do
    erb :add_class
  end
  
  post "class/add"
  
  klass = Klass.new({
    student.each do |student|
      Student.new(:name => params[:name], :grade => params[:grade])
    end
    })
    student.save
    :name => params[:name]
  })
  klass.save
  
  redirect "/"
  
  end
end