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

ActiveRecord::Schema.define(version: 20131204193227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: true do |t|
    t.string  "attachment"
    t.integer "blog_record_id"
  end

  create_table "blog_records", force: true do |t|
    t.string   "type"
    t.text     "content"
    t.text     "description"
    t.string   "title"
    t.boolean  "published"
    t.datetime "published_at"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blog_records", ["slug"], name: "index_blog_records_on_slug", unique: true, using: :btree
  add_index "blog_records", ["type"], name: "index_blog_records_on_type", using: :btree

  create_table "blog_records_tags", id: false, force: true do |t|
    t.integer "blog_record_id"
    t.integer "tag_id"
  end

  add_index "blog_records_tags", ["blog_record_id"], name: "index_blog_records_tags_on_blog_record_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.integer  "blog_record_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string  "image"
    t.integer "blog_record_id"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
