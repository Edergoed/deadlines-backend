class AddAndEditDeadline < ActiveRecord::Migration
	def change
		rename_column :deadlines, :user_id, :creator_id
		rename_index :deadlines, :user_id, :creator_id
		add_column :deadlines, :editor_id, :integer
		add_index :deadlines, :editor_id
	end
end