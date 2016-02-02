class DeadlineUser < ActiveRecord::Migration
def self.up
    create_table :deadlines_editors, :id => false do |t|
      t.integer :deadline_id
      t.integer :editor_id
    end
  end

  def self.down
    drop_table :deadlines_editors
  end
end
