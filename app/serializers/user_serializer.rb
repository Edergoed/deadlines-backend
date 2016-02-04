class UserSerializer < ActiveModel::Serializer
	attributes :id, :email, :klass, :created_at, :updated_at

	has_many :created_deadlines, embed: :ids, :serializer => ShortDeadlineSerializer
	has_many :edited_deadlines, embed: :object, :serializer => ShortDeadlineSerializer
end
