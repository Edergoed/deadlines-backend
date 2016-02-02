class Deadline < ActiveRecord::Base
	validates :title, :subject, :content, :creator_id, presence: true
	validates :group_id, :klass, presence: true, allow_nil: true
	validates :editor_id, presence: true , allow_nil: true
	validates :deadlineDateTime, presence: true

	belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"
#has_and_belongs_to_many :students, :class_name => "User", :join_table => "schools_students", :association_foreign_key => "student_id"
	has_and_belongs_to_many :editor, :association_foreign_key => "editor_id", :class_name => "User", :join_table => "deadlines_editors"
end
