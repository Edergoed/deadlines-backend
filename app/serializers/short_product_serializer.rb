class ShortProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :published
end