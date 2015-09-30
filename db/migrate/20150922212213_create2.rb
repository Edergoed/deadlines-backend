class Create2 < ActiveRecord::Migration
    def self.up
        create_table "deadlines", force: :cascade do |t|
            t.string   "title",      limit: 255,   default: ""
            t.string   "subject",    limit: 255
            t.datetime "deadlineDateTime"
            t.integer  "class_id",   limit: 4
            t.integer  "group_id",   limit: 4
            t.text     "content",    limit: 65535
            t.boolean  "published",                default: false
            t.integer  "creator_id", limit: 4
            t.integer  "editor_id",  limit: 4
            t.datetime "created_at"
            t.datetime "updated_at"
        end

        add_index "deadlines", ["creator_id"], name: "index_deadlines_on_creator_id", using: :btree
        add_index "deadlines", ["editor_id"], name: "index_deadlines_on_editor_id", using: :btree

        create_table "users", force: :cascade do |t|
            t.string   "email",                  limit: 255, default: "", null: false
            t.string   "encrypted_password",     limit: 255, default: "", null: false
            t.string   "reset_password_token",   limit: 255
            t.datetime "reset_password_sent_at"
            t.datetime "remember_created_at"
            t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
            t.datetime "current_sign_in_at"
            t.datetime "last_sign_in_at"
            t.string   "current_sign_in_ip",     limit: 255
            t.string   "last_sign_in_ip",        limit: 255
            t.datetime "created_at",                                      null: false
            t.datetime "updated_at",                                      null: false
            t.string   "auth_token",             limit: 255, default: ""
        end

        add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
        add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
        add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    end

    def self.down
        drop_table "deadlines"
        drop_table "users"
    end
end