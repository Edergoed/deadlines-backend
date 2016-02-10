class Deadline < ActiveRecord::Base
	validates :title, :subject, :content, :creator_id, presence: true
	validates :group_id, :klass, presence: true, allow_nil: true
	#validates :editor_id, presence: true , allow_nil: true
	validates :deadlineDateTime, presence: true

	belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"
#has_and_belongs_to_many :students, :class_name => "User", :join_table => "schools_students", :association_foreign_key => "student_id"
	#has_and_belongs_to_many :editor, :association_foreign_key => "editor_id", :class_name => "User", :join_table => "deadlines_editors"
	#   has_and_belongs_to_many :klasses, :association_foreign_key => "klass_id", :class_name => "Klass", :join_table => "deadlines_klasses"
    has_many :assignments
	has_many :klasses, through: :assignments
    has_many :deadline_edits
    has_many :editors, :foreign_key => "editor_id", :class_name => "User", through: :deadline_edits
end
