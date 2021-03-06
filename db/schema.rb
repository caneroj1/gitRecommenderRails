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

ActiveRecord::Schema.define(version: 20150512165721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "repositories", force: :cascade do |t|
    t.text     "name"
    t.text     "readme_url"
    t.datetime "pushed_at"
    t.integer  "watchers"
    t.hstore   "languages"
    t.text     "readme_text"
    t.boolean  "is_private",           default: false
    t.integer  "user_id"
    t.integer  "belongs_to_on_github"
    t.boolean  "is_forked",            default: false
    t.text     "description"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "github_id"
    t.string   "login"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "access_token",       default: ""
    t.string   "avatar_url",         default: ""
    t.text     "language_breakdown"
    t.string   "keyword_one"
    t.string   "keyword_two"
    t.string   "keyword_three"
    t.string   "keyword_four"
    t.string   "keyword_five"
  end

  add_index "users", ["github_id"], name: "index_users_on_github_id", using: :btree
  add_index "users", ["login"], name: "index_users_on_login", using: :btree

end
