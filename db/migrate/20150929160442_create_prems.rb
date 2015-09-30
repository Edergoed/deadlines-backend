class CreatePrems < ActiveRecord::Migration
  def change
    create_table :prems do |t|

      t.timestamps null: false
    end
  end
end
