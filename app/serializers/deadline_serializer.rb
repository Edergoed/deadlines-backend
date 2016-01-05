class DeadlineSerializer < ActiveModel::Serializer
	require 'digest/md5'
	# embed :ids, include: true
	attributes :id, :title, :subject, :deadlineDateTime, :klass, :group_id, :content, :published
	has_one :creator, :key => :creator, embed: :objects, serializer: ShortUserSerializer
	has_one :editor, :key => :creator, embed: :objects, serializer: ShortUserSerializer
	#def creator
	#	ShortUserSerializer.new(object.creator, root: false)
	#end

	# def editor
	# 	ShortUserSerializer.new(object.user, root: false)
	# end


end