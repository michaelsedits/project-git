class Grade < ActiveRecord::Base
  has_one :klass
  has_one :student
end