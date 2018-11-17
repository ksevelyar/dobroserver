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

ActiveRecord::Schema.define(version: 20_130_927_194_205) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'attachments', force: :cascade do |t|
    t.string  'attachment'
    t.integer 'blog_record_id'
  end

  add_index 'attachments', ['blog_record_id'], name: 'index_attachments_on_blog_record_id', using: :btree

  create_table 'blog_records', force: :cascade do |t|
    t.string   'type'
    t.text     'content'
    t.text     'description'
    t.string   'title'
    t.boolean  'published'
    t.datetime 'published_at'
    t.integer  'user_id'
    t.string   'slug'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'blog_records', ['published_at'], name: 'index_blog_records_on_published_at', using: :btree
  add_index 'blog_records', ['slug'], name: 'index_blog_records_on_slug', unique: true, using: :btree

  create_table 'blog_records_tags', id: false, force: :cascade do |t|
    t.integer 'blog_record_id'
    t.integer 'tag_id'
  end

  add_index 'blog_records_tags', %w[blog_record_id tag_id], name: 'index_blog_records_tags_on_blog_record_id_and_tag_id', using: :btree

  create_table 'comments', force: :cascade do |t|
    t.string   'name'
    t.string   'email'
    t.text     'content'
    t.integer  'blog_record_id'
    t.string   'ip'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'comments', ['blog_record_id'], name: 'index_comments_on_blog_record_id', using: :btree

  create_table 'images', force: :cascade do |t|
    t.string  'image'
    t.integer 'blog_record_id'
  end

  add_index 'images', ['blog_record_id'], name: 'index_images_on_blog_record_id', using: :btree

  create_table 'tags', force: :cascade do |t|
    t.string   'name'
    t.string   'slug'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'tags', ['slug'], name: 'index_tags_on_slug', unique: true, using: :btree

  create_table 'users', force: :cascade do |t|
    t.string   'name'
    t.string   'email'
    t.string   'password_digest'
    t.string   'remember_token'
    t.boolean  'admin'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'users', ['email'], name: 'index_users_on_email', unique: true, using: :btree
end
