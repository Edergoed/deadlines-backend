class CreateStructure < ActiveRecord::Migration

  create_table "assignments" do |t|
    t.integer  "deadline_id", limit: 4
    t.integer  "klass_id",    limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "deadline_edits" do |t|
    t.integer  "deadline_id", limit: 4
    t.integer  "editor_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "deadlines" do |t|
    t.string   "title",            limit: 255,   default: ""
    t.string   "subject",          limit: 255
    t.datetime "deadlineDateTime"
    t.integer  "klass",            limit: 4
    t.integer  "group_id",         limit: 4
    t.text     "content",          limit: 65535
    t.boolean  "published",                      default: false
    t.integer  "creator_id",       limit: 4
    t.integer  "editor_id_nope",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deadlines", ["creator_id"], name: "index_deadlines_on_creator_id", using: :btree
  add_index "deadlines", ["editor_id_nope"], name: "index_deadlines_on_editor_id", using: :btree

  create_table "deadlines_editors", id: false do |t|
    t.integer "deadline_id", limit: 4
    t.integer "editor_id",   limit: 4
  end

  create_table "deadlines_klasses", id: false do |t|
    t.integer "deadline_id", limit: 4
    t.integer "klass_id",    limit: 4
  end

  create_table "klasses" do |t|
    t.string   "name",       limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "perms" do |t|
    t.string   "name",       limit: 11
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "perms_roles", id: false do |t|
    t.integer "role_id", limit: 4
    t.integer "perm_id", limit: 4
  end

  add_index "perms_roles", ["perm_id"], name: "index_roles_perms_on_perms_id", using: :btree
  add_index "perms_roles", ["role_id"], name: "index_roles_perms_on_roles_id", using: :btree

  create_table "roles" do |t|
    t.string   "name",       limit: 11
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "roles_perms", id: false do |t|
    t.integer "roles_id", limit: 4
    t.integer "perms_id", limit: 4
  end

  add_index "roles_perms", ["perms_id"], name: "index_roles_perms_on_perms_id", using: :btree
  add_index "roles_perms", ["roles_id"], name: "index_roles_perms_on_roles_id", using: :btree

  create_table "users" do |t|
    t.string   "firstname",              limit: 11
    t.string   "lastname",               limit: 11
    t.string   "prefix",                 limit: 11
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "klass",                  limit: 4
    t.integer  "role",                   limit: 4,   default: 0
    t.string   "activation_token",       limit: 255
    t.boolean  "active",                             default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
end
