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

ActiveRecord::Schema.define(version: 20170227154050) do

  create_table "characters", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "dressing_costumes", force: :cascade do |t|
    t.integer  "avatar_id",  limit: 4
    t.integer  "item_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "dressing_costumes", ["avatar_id"], name: "index_dressing_costumes_on_avatar_id", using: :btree

  create_table "equipment_characters", force: :cascade do |t|
    t.integer  "character_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "equipment_characters", ["character_id"], name: "index_equipment_characters_on_character_id", using: :btree

  create_table "equipment_weapons", force: :cascade do |t|
    t.integer  "equipment_character_id", limit: 4
    t.integer  "item_id",                limit: 4
    t.integer  "cost",                   limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "equipment_weapons", ["equipment_character_id"], name: "index_equipment_weapons_on_equipment_character_id", using: :btree

end
