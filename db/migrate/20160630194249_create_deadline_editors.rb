class CreateDeadlineEditors < ActiveRecord::Migration
  def change
    create_table :deadline_editors do |t|

      t.timestamps null: false
      t.integer  "deadline_id",        limit: 4, null:false
      t.integer  "editor_id",          limit: 4, null:false
    end
  end
end
