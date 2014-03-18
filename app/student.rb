class Student < ActiveRecord::Base
  has_many :classes
  has_many :teachers
  has_many :semesters
end