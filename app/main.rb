require 'pry'
require 'active_record'
require 'logger'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'
#small changes
class System < Sinatra::Base
  #student - name, teacher_id, grade_id
  post "/add_students" do
    params.each do |new_student|
       Student.create(:name=>new_student[:name], :teacher_id =>new_student[:teacher_id], :grade_id =>new_student[:grade_id]) 
     end
  end
  
   
  get "/semester/:id" do
    @semester=Semester.where(:year=>params[:semester.year], :term=>params[:semester_term])
    @klasses=Klass.where(params[:id] => semester_id)
    erb :semester
  end
  
  get "/semester/:year/:spring_or_fall" do
    @klasses=Klass.where(:year=>params[:year], :spring_or_fall=> params[:spring_or_fall])  
  end
end