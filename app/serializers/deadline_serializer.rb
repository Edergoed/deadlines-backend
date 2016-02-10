class DeadlineSerializer < ActiveModel::Serializer
	require 'digest/md5'
	# embed :ids, include: true
	#attributes :id, :title, :subject, :deadlineDateTime, :klass_id, :group_id, :content, :published
	attributes :id, :title, :subject, :deadlineDateTime, :group_id, :content, :published
	has_one :creator, :key => :creator, embed: :objects, serializer: ShortUserSerializer
	has_many :editors, :through => :deadline_edits, :foreign_key => "editor_id", :source => :deadlines, :key => :editors, embed: :objects, serializer: ShortUserSerializer
	has_many :klasses, :through => :assignments, embed: :ids
	#def creator
	#	ShortUserSerializer.new(object.creator, root: false)
	#end

	# def editor
	# 	ShortUserSerializer.new(object.user, root: false)
	# end


end
