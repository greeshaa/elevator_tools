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

ActiveRecord::Schema.define(version: 20140430104006) do

  create_table "builds", force: true do |t|
    t.integer  "street_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "node_id"
    t.integer  "porch_count"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", force: true do |t|
    t.integer  "partner_id"
    t.string   "number"
    t.date     "signed_at"
    t.date     "lifetime"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "destinations", force: true do |t|
    t.integer  "node_id"
    t.integer  "lift_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elevator_control_stations", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment", force: true do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "equipment_list_id"
    t.string   "factory_sn"
    t.date     "installed_at"
    t.string   "notes"
    t.integer  "porch_id"
    t.boolean  "broken",            default: false
  end

  create_table "equipment_lists", force: true do |t|
    t.integer  "equipment_type_id"
    t.string   "manufacturer"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "equipment_movements", force: true do |t|
    t.integer  "destination_id"
    t.integer  "equipment_id"
    t.string   "movement"
    t.string   "reason"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "node_id"
  end

  create_table "equipment_types", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "inspections", force: true do |t|
    t.integer  "lift_id"
    t.date     "inspection_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "plained_at"
  end

  create_table "ip_addresses", force: true do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "mask"
    t.string   "gate"
    t.integer  "node_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lift_types", force: true do |t|
    t.integer  "manufacturer_id"
    t.string   "model"
    t.string   "function"
    t.string   "doors"
    t.integer  "capacity"
    t.integer  "speed"
    t.integer  "elevation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "lifts", force: true do |t|
    t.integer  "node_id"
    t.integer  "porch_id"
    t.string   "regnum"
    t.string   "sernum"
    t.integer  "stopscount"
    t.integer  "introduced_at"
    t.integer  "overhaul_at"
    t.integer  "standart_life"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "position"
    t.integer  "lift_type_id"
    t.integer  "elevator_control_station_id"
    t.integer  "contract_id"
    t.integer  "mechanic_id"
    t.date     "inspection_at"
    t.date     "made_at"
    t.integer  "manufacturer_id"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "function"
    t.string   "doors"
    t.integer  "capacity"
    t.integer  "speed",                       limit: 3
    t.integer  "elevation",                   limit: 3
  end

  create_table "manufacturers", force: true do |t|
    t.string   "short_name"
    t.string   "full_name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "mechanics", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "street_id"
    t.integer  "build_id"
    t.integer  "porch_id"
    t.integer  "dataport"
    t.integer  "soundport"
  end

  create_table "partners", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "porches", force: true do |t|
    t.integer  "build_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "contact"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "streets", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "city_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "email"
    t.string   "remember_token"
    t.string   "runame"
    t.boolean  "admin",           default: false
    t.boolean  "foreman"
    t.boolean  "lask"
    t.boolean  "management"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "users_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
