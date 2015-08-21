class ProductSerializer < ActiveModel::Serializer
	embed :ids, include: true
	attributes :id, :title, :price, :published, :creator, :editor
	# has_one :user, :key => :creator, embed: :objects, serializer: ShortUserSerializer
	# def creator
	# 	ShortUserSerializer.new(object.user, root: false)
	# end

	# def editor
	# 	ShortUserSerializer.new(object.user, root: false)
	# end
end