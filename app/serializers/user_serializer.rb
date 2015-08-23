class UserSerializer < ActiveModel::Serializer
	embed :ids
	attributes :id, :email, :created_at, :updated_at, :auth_token

	has_many :created_deadlines, embed: :ids,  :include => false, :serializer => ShortDeadlineSerializer
	has_many :edited_deadlines, embed: :ids,  :include => false, :serializer => ShortDeadlineSerializer
end