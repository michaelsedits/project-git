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
  
  # Class for Klass
  get "/class/:id" do
    @klass = Klass.find(params[:id])
    @grade = Grade.where({:klass_id => params[:id]})
    
    erb :class

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
