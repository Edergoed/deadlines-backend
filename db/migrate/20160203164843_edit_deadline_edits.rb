class EditDeadlineEdits < ActiveRecord::Migration
  def change
      rename_column :deadline_edits, :user_id, :editor_id

  end
end
