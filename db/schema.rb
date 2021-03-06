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

ActiveRecord::Schema.define(version: 20140918141502) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "builds", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "street_id"
    t.integer  "porch_count"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connections", force: true do |t|
    t.string   "title"
    t.integer  "porch_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "function"
    t.string   "note"
    t.integer  "phone_1"
    t.integer  "phone_2"
    t.string   "e_mail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts_partners", id: false, force: true do |t|
    t.integer "contact_id"
    t.integer "partner_id"
  end

  add_index "contacts_partners", ["contact_id"], name: "index_contacts_partners_on_contact_id", using: :btree
  add_index "contacts_partners", ["partner_id"], name: "index_contacts_partners_on_partner_id", using: :btree

  create_table "contracts", force: true do |t|
    t.integer  "partner_id"
    t.string   "number"
    t.date     "signed_at"
    t.date     "lifetime"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tlr_id"
  end

  create_table "districts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "downtimes", force: true do |t|
    t.integer  "lift_id"
    t.date     "dt_date"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elevator_control_stations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "equipment_list_id"
    t.string   "factory_sn"
    t.date     "installed_at"
    t.string   "notes"
    t.integer  "porch_id"
    t.boolean  "broken",            default: false
  end

  create_table "equipment_line_items", force: true do |t|
    t.integer  "equipment_id"
    t.integer  "equipment_move_buffer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment_lists", force: true do |t|
    t.integer  "equipment_type_id"
    t.string   "name"
    t.string   "manufacturer"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment_move_buffers", force: true do |t|
    t.integer  "equipment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment_movements", force: true do |t|
    t.integer  "equipment_id"
    t.string   "movement"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "node_id"
    t.integer  "porch_id"
    t.integer  "build_id"
    t.integer  "street_id"
  end

  create_table "equipment_types", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experts", force: true do |t|
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factory_calendars", force: true do |t|
    t.integer  "month"
    t.string   "month_name"
    t.integer  "cal_days"
    t.integer  "work_days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foremen", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspections", force: true do |t|
    t.integer  "lift_id"
    t.date     "inspection_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "next_inspection_at"
    t.boolean  "active",             default: true
    t.boolean  "rebuke"
    t.string   "comment"
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
    t.integer  "connection_id"
  end

  create_table "lift_types", force: true do |t|
    t.integer  "manufacturer_id"
    t.integer  "capacity"
    t.string   "function"
    t.string   "doors"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "model"
    t.integer  "elevation"
    t.integer  "speed"
  end

  create_table "lifts", force: true do |t|
    t.integer  "node_id"
    t.integer  "porch_id"
    t.string   "position"
    t.string   "regnum"
    t.string   "sernum"
    t.string   "function"
    t.integer  "stopscount"
    t.integer  "capacity"
    t.integer  "introduced_at"
    t.integer  "overhaul_at"
    t.integer  "standart_life"
    t.integer  "lift_type_id"
    t.integer  "elevator_control_station_id"
    t.integer  "contract_id"
    t.integer  "mechanic_id"
    t.date     "inspection_at"
    t.date     "made_at"
    t.integer  "manufacturer_id"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "doors"
    t.integer  "speed"
    t.integer  "elevation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tlr_id"
    t.integer  "district_id"
    t.string   "service_payment"
    t.integer  "expert_id"
    t.integer  "price_id"
  end

  create_table "manufacturers", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
    t.string   "full_name"
  end

  create_table "mechanics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "foreman_id"
  end

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "street_id"
    t.integer  "build_id"
    t.integer  "porch_id"
    t.integer  "dataport"
    t.integer  "soundport"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overhauls", force: true do |t|
    t.string   "kind"
    t.date     "produced_at"
    t.string   "description"
    t.integer  "new_lifetime"
    t.integer  "lift_id"
    t.boolean  "active",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "porches", force: true do |t|
    t.integer  "build_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.decimal  "cost",        precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "floor"
  end

  create_table "providers", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "contact"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "street_kinds", force: true do |t|
    t.string   "name"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "streets", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.integer  "street_kind_id"
  end

  create_table "temp_serv_meches", force: true do |t|
    t.integer  "lift_id"
    t.integer  "mechanic_id"
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_sheet_kinds", force: true do |t|
    t.string   "title"
    t.string   "letter_code"
    t.integer  "number_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_sheets", force: true do |t|
    t.integer  "time_sheet_kind_id"
    t.integer  "mechanic_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tlrs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "foreman",         default: false
    t.boolean  "management",      default: false
    t.boolean  "lask",            default: false
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "users_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
