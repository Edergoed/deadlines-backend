class ShortUserSerializer < ActiveModel::Serializer
	embed :ids
	attributes :id, :email, :created_at, :updated_at, :auth_token
end