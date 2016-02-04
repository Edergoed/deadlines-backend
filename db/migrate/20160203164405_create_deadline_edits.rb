class CreateDeadlineEdits < ActiveRecord::Migration
    def change
        create_table :deadline_edits do |t|
            t.timestamps null: false
        end

        add_column :deadline_edits, :deadline_id, :integer
        add_column :deadline_edits, :user_id, :integer
    end
end
