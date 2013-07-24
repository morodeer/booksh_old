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

ActiveRecord::Schema.define(version: 20130724112725) do

  create_table "authors", force: true do |t|
    t.string   "name"
    t.string   "real_name"
    t.string   "wiki_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",      default: true, null: false
  end

  add_index "authors", ["name"], name: "index_authors_on_name", using: :btree
  add_index "authors", ["real_name"], name: "index_authors_on_real_name", using: :btree

  create_table "book_author_relationships", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
    t.integer  "author_id"
  end

  create_table "book_specimens", force: true do |t|
    t.integer  "book_id"
    t.integer  "owner_id"
    t.integer  "temp_owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "author_names"
    t.text     "detail"
    t.string   "isbn"
    t.string   "clean_isbn"
    t.string   "publish_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["clean_isbn"], name: "index_books_on_clean_isbn", using: :btree
  add_index "books", ["title"], name: "index_books_on_title", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "geo_coordinates"
  end

  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
