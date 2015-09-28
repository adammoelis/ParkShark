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

ActiveRecord::Schema.define(version: 20150928202010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string   "make"
    t.string   "model"
    t.string   "color"
    t.integer  "year"
    t.string   "license_plate"
    t.integer  "visitor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "cars", ["visitor_id"], name: "index_cars_on_visitor_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "author_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "messages", ["author_id"], name: "index_messages_on_author_id", using: :btree
  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "body"
    t.integer  "spot_id"
    t.integer  "visitor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["spot_id"], name: "index_reviews_on_spot_id", using: :btree
  add_index "reviews", ["visitor_id"], name: "index_reviews_on_visitor_id", using: :btree

  create_table "spots", force: :cascade do |t|
    t.string   "title"
    t.string   "location"
    t.boolean  "available"
    t.datetime "date"
    t.float    "price"
    t.string   "image_url"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "spots", ["owner_id"], name: "index_spots_on_owner_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "spot_id"
    t.boolean  "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["spot_id"], name: "index_transactions_on_spot_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "location"
    t.string   "image_url"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reviews", "spots"
  add_foreign_key "transactions", "spots"
end
