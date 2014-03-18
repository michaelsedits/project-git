require 'pry'
require 'active_record'
require 'logger'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'
#small changes
class System < Sinatra::Base
  
  get "/" do
    @semester = Semester.where('current = ?', 't')
    @klasses = Klass.where('semester_id = ?', '@semester')
    @teachers = Teacher.all
    
    @past_semesters = Semester.where('current = ?', 'f')
    erb :home
  end
   
  get "/semester/:id" do
      @semester = Semester.find(params[:id])
      @klasses = Klass.where((params[:id]) => semester_id)
      erb :display_classes
  end

  get "/add_class" do
    erb :add_class
  end
  
  get "/add_teacher" do
    erb :add_teacher
  end
  
  # Class for Klass
  get "/class/:id" do
    @klass = Klass.find(params[:id])
    @grade = Grade.where({:klass_id => params[:id]})
    
    erb :class
  end
  
  post "/add_class" do
    @teacher_id = params[:teacher]
    unless Semester.where('year = ?', params[:year]).where('spring_or_fall = ?', params[:spring_or_fall])
      @semester_id = Semester.create({
      :year => params[:year]
      :spring_or_fall => params[:spring_or_fall]
      })
    end
    
    Klass.create({
      :name => params[:name],
      :teacher_id => @teacher_id.id
      :semester_id => @semester_id
    })
    
    redirect "/"
  end
  
  #student - name, teacher_id, grade_id
  post "/add_students" do
      params.each do |new_student|
         Student.create({
           :name => new_student[:name], 
           :teacher_id => new_student[:teacher_id], 
           :grade_id => new_student[:grade_id]
           }) 
      end
      
      redirect "/"
  end
  
  post "/add_teacher" do
    teacher = Teacher.create({
      :name => params[:name]
      })
      
      redirect "/"
  end

end
