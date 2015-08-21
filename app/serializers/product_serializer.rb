class ProductSerializer < ActiveModel::Serializer
	embed :ids, include: true
	attributes :id, :title, :price, :published
	has_one :user,embed: :objects, serializer: ShortUserSerializer 
end