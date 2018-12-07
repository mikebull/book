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

ActiveRecord::Schema.define(version: 20181207161816) do

  create_table "chapters", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "comments", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chapter_id"
    t.string "paragraph_reference"
    t.index ["chapter_id"], name: "index_comments_on_chapter_id"
  end

  create_table "paragraphs", id: false, force: :cascade do |t|
    t.string "hash"
    t.text "paragraph"
    t.string "node_type"
    t.integer "node_position"
    t.integer "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_paragraphs_on_chapter_id"
  end

end
