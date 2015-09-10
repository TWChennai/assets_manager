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

ActiveRecord::Schema.define(version: 20150912014037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "asset_owner_histories", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "asset_id"
    t.string   "event",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asset_owner_histories", ["asset_id"], name: "index_asset_owner_histories_on_asset_id", using: :btree
  add_index "asset_owner_histories", ["owner_type", "owner_id"], name: "index_asset_owner_histories_on_owner_type_and_owner_id", using: :btree

  create_table "asset_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "common_resource"
  end

  create_table "assets", force: :cascade do |t|
    t.string   "bar_code"
    t.integer  "asset_type_id"
    t.string   "status"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "serial_number"
    t.integer  "project_id"
    t.integer  "brand_id"
    t.integer  "location_id"
  end

  add_index "assets", ["asset_type_id"], name: "index_assets_on_asset_type_id", using: :btree
  add_index "assets", ["brand_id"], name: "index_assets_on_brand_id", using: :btree
  add_index "assets", ["location_id"], name: "index_assets_on_location_id", using: :btree
  add_index "assets", ["project_id"], name: "index_assets_on_project_id", using: :btree
  add_index "assets", ["user_id"], name: "index_assets_on_user_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "location_id"
  end

  add_index "projects", ["location_id"], name: "index_projects_on_location_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin"
  end

end
