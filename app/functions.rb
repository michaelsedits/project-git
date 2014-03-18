require_relative './klass.rb'
require_relative './student.rb'
require_relative './teacher.rb'
require_relative './grade.rb'
require_relative './semester.rb'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',require "functions"
  
  :database => (ENV['RACK_ENV'] == 'test') ? "system.test" : "system"
)

ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'klasses'
    create_table :klasses do |table|
      table.column :teacher_id, :integer
      table.column :student_id, :integer
      table.column :semester_id, :integer
      table.column :name, :string
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'teachers'
    create_table :teachers do |table|
      table.column :klass_id, :integer
      table.column :name, :string
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'students'
    create_table :students do |table|
      table.column :name, :string
      table.column :teacher_id, :integer
      table.column :grade_id, :integer
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'semesters'
    create_table :semesters do |table|
      table.column :spring_or_fall, :string
      table.column :year, :integer
      table.column :current, :boolean
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'grades'
    create_table :grades do |table|
      table.column :klass_id, :integer
      table.column :student_id, :integer
      table.column :grade, :integer
    end
  end
  
end