class ShortUserSerializer < ActiveModel::Serializer
	require 'digest/md5'
	# embed :ids
	attributes :id, :firstname, :lastname, :prefix, :gravatarHash, :created_at, :updated_at

	def gravatarHash
		Digest::MD5.hexdigest(object.email)
	end
end
