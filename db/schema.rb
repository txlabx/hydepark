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

ActiveRecord::Schema.define(version: 20150609122856) do

  create_table "comment_likes", force: true do |t|
    t.integer  "comment_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "parent_id",  null: false
    t.integer  "post_id",    null: false
    t.text     "caption"
    t.text     "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "friend_id",  null: false
    t.string   "state",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_likes", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_seens", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id",              null: false
    t.text     "caption",              null: false
    t.text     "video_link",           null: false
    t.text     "video_thumbnail_link", null: false
    t.text     "image_link",           null: false
    t.text     "video_angle",          null: false
    t.string   "privacy",              null: false
    t.integer  "topic_id",             null: false
    t.integer  "reply_count",          null: false
    t.string   "beam_type",            null: false
    t.integer  "mute",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filter",               null: false
    t.integer  "video_length",         null: false
  end

  create_table "tags", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "name",       null: false
    t.text     "image",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "full_name"
    t.string   "email"
    t.text     "profile_link"
    t.text     "cover_link"
    t.string   "profile_type"
    t.string   "cover_type"
    t.integer  "is_celeb"
    t.text     "password"
    t.string   "account_type"
    t.text     "session_token"
    t.integer  "last_login",    limit: 8
    t.date     "date_of_birth"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
