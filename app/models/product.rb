class Product < ActiveRecord::Base
  validates :title, :creator_id, :editor_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"
  belongs_to :editor, :foreign_key => "editor_id", :class_name => "User"

end