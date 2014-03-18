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
         Student.create({:name=>new_student[:name], :teacher_id =>new_student[:teacher_id], :grade_id =>new_student[:grade_id]}) 
       end
    end
  
   
  get "/semester/:id" do
      @semester = Semester.find(params[:id])
      @klasses=Klass.where((params[:id]) => semester_id)
      erb :display_classes
  end

  
  def get_current_semester
    max_year=Semester.maximum('year')
    the_current_semester=Semester.where(:year=>max_year)
    if the_current_semester.length>1
     the_current_semester.each do |sem|    
        if sem.term=="Spring"
             sem.current=true
        elsif sem.term=="Fall"
             sem.current=true    
        end
     end
    end
  end
