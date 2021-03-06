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

ActiveRecord::Schema.define(version: 20160615052221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "definition_races", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "definition_unit_classes", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "definition_units", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "race_id"
    t.integer  "unit_class_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "life"
    t.integer  "armor"
    t.integer  "dexterity"
    t.integer  "initiative"
    t.integer  "attacks"
    t.integer  "power"
  end

  create_table "game_battle_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_battle_participants", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "division_id"
    t.string   "role"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "game_divisions", force: :cascade do |t|
    t.integer  "plannet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_plannets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_squadrons", force: :cascade do |t|
    t.integer  "division_id"
    t.integer  "unit_id"
    t.integer  "quantity"
    t.integer  "damage",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
