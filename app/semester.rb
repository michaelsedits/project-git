class Semester < ActiveRecord::Base
  has_many :klasses
  
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
end