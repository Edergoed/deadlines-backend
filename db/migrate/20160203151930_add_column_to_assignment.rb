class AddColumnToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :deadline_id, :integer
    add_column :assignments, :klass_id, :integer
  end
end
