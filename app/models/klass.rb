class Klass < ActiveRecord::Base
	has_and_belongs_to_many :deadline
	#has_and_belongs_to_many :deadlines, :class_name => "Deadline",  :foreign_key=>"klass_id", :class_name => "Deadline", :join_table => "deadlines_klasses"
    has_many :assignments
	has_many :deadlines, through: :assignmens
end
