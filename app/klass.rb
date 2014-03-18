class Klass < ActiveRecord::Base
  belongs_to :semester
  has_many :students
  has_one :teacher
end

