require 'pry'
require 'active_record'
require 'logger'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'

class System < Sinatra::Base
  get "/" do
    @semester = Semester.where('current = ?', 't')
    @klasses = Klass.where('semester_id = ?', '@semester')
    
    @past_semesters = Semester.where('current = ?', 'f')
    erb :home
  end

  get "/add_class" do
    erb :add_class
  end
  
  get "/add_teacher" do
    erb :add_teacher
  end
  
  post "/add_class" do
    @student_id = Student.find_by_name(params[:student])
    @teacher_id = Teacher.find_by_name(params[:teacher])
    @semester_id = Semester.where('year = ?', params[:year]}).where('spring_or_fall = ?', params[:spring_or_fall]})
    
    klass = Klass.new({
      :name => params[:name]
      :teacher_id => @teacher_id
      :semester_id => @semester_id
      params[:student].each {|x| @student_id => x }
      params[:grade].each {|x| @student_id => x }
    })
    klass.save
  
    redirect "/"
  end
  
  post "/add_teacher" do
    teacher = Teacher.new({
      :name => params[:name]
      })
      teacher.save
      
      redirect "/"
  end

end