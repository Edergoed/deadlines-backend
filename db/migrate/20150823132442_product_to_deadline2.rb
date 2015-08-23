class ProductToDeadline2 < ActiveRecord::Migration
  def change
  	remove_column :deadlines, :price
  	add_column :deadlines, :subject, :string
  	add_column :deadlines,:deadline, :datetime
  	add_column :deadlines,:class, :integer
  	add_column :deadlines,:group, :integer
  	add_column :deadlines,:content, :text
  end
end
