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

ActiveRecord::Schema.define(version: 20170224133754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed_sources", force: :cascade do |t|
    t.integer  "feed_id",    null: false
    t.integer  "source_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_feed_sources_on_feed_id", using: :btree
    t.index ["source_id"], name: "index_feed_sources_on_source_id", using: :btree
  end

  create_table "feeds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title",      null: false
  end

  create_table "job_offers", force: :cascade do |t|
    t.string   "url",          null: false
    t.string   "title"
    t.text     "raw_content"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "source_id"
    t.text     "content"
    t.index ["source_id"], name: "index_job_offers_on_source_id", using: :btree
  end

  create_table "sources", force: :cascade do |t|
    t.string   "title"
    t.string   "url",         null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "source_type", null: false
    t.datetime "fetched_at"
    t.index ["url"], name: "index_sources_on_url", unique: true, using: :btree
  end

  add_foreign_key "job_offers", "sources"
end