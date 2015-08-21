class AddAndEditProduct < ActiveRecord::Migration
	def change
		rename_column :products, :user_id, :creator_id
		rename_index :products, :user_id, :creator_id
		add_column :products, :editor_id, :integer
		add_index :products, :editor_id
	end
end