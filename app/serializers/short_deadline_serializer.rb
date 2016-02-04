class ShortDeadlineSerializer < ActiveModel::Serializer
  attributes :id, :title, :subject, :deadlineDateTime, :group_id, :content, :published
end