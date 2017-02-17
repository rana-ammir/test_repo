# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170217134814) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.date     "activity_date"
    t.time     "start_time"
    t.time     "end_time"
    t.decimal  "hours",                        precision: 5, scale: 2, default: 0.0
    t.integer  "created_by_user_id", limit: 4
    t.integer  "updated_by_user_id", limit: 4
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  create_table "admin_users", force: :cascade do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "description", limit: 255
    t.integer  "number",      limit: 4
    t.integer  "division_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "assets", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.integer  "assetable_id",       limit: 4
    t.string   "assetable_type",     limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size",    limit: 4
    t.datetime "asset_updated_at"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "division_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "organization_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "goals", force: :cascade do |t|
    t.text     "description",   limit: 65535
    t.integer  "area_id",       limit: 4
    t.integer  "department_id", limit: 4
    t.integer  "number",        limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "active",                      default: true
  end

  create_table "objectives", force: :cascade do |t|
    t.text     "description",            limit: 65535
    t.string   "status",                 limit: 255
    t.date     "begin_on"
    t.date     "end_on"
    t.integer  "goal_id",                limit: 4
    t.integer  "number",                 limit: 4
    t.decimal  "totalhours",                           precision: 5,  scale: 2, default: 0.0
    t.decimal  "percent_complete",                     precision: 10, scale: 2, default: 0.0
    t.integer  "strategies_count",       limit: 4,                              default: 0
    t.date     "requested_by_date"
    t.integer  "on_going_carry_forward", limit: 2,                              default: 0
    t.decimal  "budgeted_dollars",                     precision: 15, scale: 2
    t.decimal  "actual_hours",                         precision: 5,  scale: 2, default: 0.0
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "address",      limit: 65535
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.decimal  "hours_in_day",               precision: 10, scale: 2
  end

  create_table "plan_objectives", force: :cascade do |t|
    t.integer  "plan_id",      limit: 4
    t.integer  "objective_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "fiscal_year",     limit: 4
    t.date     "begin_on"
    t.date     "end_on"
    t.string   "status",          limit: 255
    t.integer  "department_id",   limit: 4
    t.integer  "organization_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "strategies", force: :cascade do |t|
    t.text     "description",          limit: 65535
    t.integer  "fiscal_year",          limit: 4
    t.integer  "budget_dollars",       limit: 2
    t.integer  "budget_fte",           limit: 8
    t.date     "begin_on"
    t.date     "end_on"
    t.decimal  "percent_complete",                   precision: 5,  scale: 2, default: 0.0
    t.decimal  "percent_of_objective",               precision: 10, scale: 2
    t.date     "completed_on"
    t.integer  "objective_id",         limit: 4
    t.integer  "number",               limit: 4
    t.decimal  "totalhours",                         precision: 5,  scale: 2, default: 0.0
    t.integer  "tactics_count",        limit: 4,                              default: 0
    t.decimal  "actual_hours",                       precision: 5,  scale: 2, default: 0.0
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
  end

  create_table "tactics", force: :cascade do |t|
    t.text     "description",         limit: 65535
    t.date     "begin_on"
    t.date     "end_on"
    t.date     "completed_on"
    t.decimal  "percent_complete",                  precision: 5,  scale: 2
    t.decimal  "percent_of_strategy",               precision: 5,  scale: 2
    t.integer  "assignee_id",         limit: 4
    t.string   "status",              limit: 255
    t.integer  "strategy_id",         limit: 4
    t.integer  "number",              limit: 4
    t.decimal  "days",                              precision: 10, scale: 2, default: 0.0
    t.decimal  "hours",                             precision: 10, scale: 2, default: 0.0
    t.decimal  "totalhours",                        precision: 5,  scale: 2, default: 0.0
    t.decimal  "actual_days",                       precision: 5,  scale: 2, default: 0.0
    t.decimal  "actual_hours",                      precision: 5,  scale: 2, default: 0.0
    t.decimal  "total_actual_hours",                precision: 5,  scale: 2, default: 0.0
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "tactic_id",       limit: 4
    t.string   "task_type",       limit: 255
    t.string   "description",     limit: 255
    t.string   "status",          limit: 255
    t.date     "due_date"
    t.integer  "requestor_id",    limit: 4
    t.integer  "assigned_to_id",  limit: 4
    t.decimal  "actual_hours",                precision: 5, scale: 2, default: 0.0
    t.date     "completion_date"
    t.decimal  "progress",                    precision: 5, scale: 2, default: 0.0
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.integer  "organization_id", limit: 4
  end

  create_table "team_objectives", force: :cascade do |t|
    t.integer  "team_id",      limit: 4
    t.integer  "objective_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "team_strategies", force: :cascade do |t|
    t.integer  "strategy_id", limit: 4
    t.integer  "team_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "team_tactics", force: :cascade do |t|
    t.integer  "team_id",    limit: 4
    t.integer  "tactic_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "team_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "team_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.boolean  "active",                      default: true
    t.integer  "organization_id", limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "user_objectives", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "objective_id", limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "owner",                  default: false
  end

  create_table "user_strategies", force: :cascade do |t|
    t.integer  "strategy_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "owner",                 default: false
  end

  create_table "user_tactics", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "tactic_id",  limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "owner",                default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.integer  "role_id",                limit: 4
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "username",               limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "organization_id",        limit: 255
    t.integer  "division_id",            limit: 4
    t.integer  "department_id",          limit: 4
    t.string   "job_title",              limit: 255
    t.boolean  "active",                             default: true
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
