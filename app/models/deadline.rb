class Deadline < ActiveRecord::Base
	validates :title, :subject, :content, :creator_id, presence: true
	validates :group_id, :klass, presence: true, allow_nil: true
	validates :editor_id, presence: true , allow_nil: true
	validates :deadlineDateTime, presence: true

	belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"
	belongs_to :editor, :foreign_key => "editor_id", :class_name => "User"
end