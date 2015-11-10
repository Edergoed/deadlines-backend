class SharedDeadlines < ActiveRecord::Migration
    def change
        create_table "deadlines_klasses", force: :cascade do |t|
            t.integer "deadline_id", limit: 4, null: false
            t.integer "klass_id", limit: 4, null: false
        end

        add_index "deadlines_klasses", ["creator_id"], name: "index_deadlines_klasses_on_creator_id", using: :btree
        add_index "deadlines_klasses", ["editor_id"], name: "index_deadlines_klasses_on_editor_id", using: :btree
    end
end
