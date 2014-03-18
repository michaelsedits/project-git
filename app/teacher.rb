class Teacher < ActiveRecord::Base
  has_many :klasses
  has_many :semesters
end