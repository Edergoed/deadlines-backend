class DeadlinesKlasses < ActiveRecord::Migration
def self.up
    create_table :deadlines_klasses, :id => false do |t|
      t.integer :deadline_id
      t.integer :klass_id
    end
  end

  def self.down
    drop_table :deadlines_klasses
  end
end
