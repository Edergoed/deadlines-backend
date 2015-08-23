class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines do |t|
      t.string :title, default: ""
      t.decimal :price, default: 0.0
      t.boolean :published, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :deadlines, :user_id
  end
end