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

ActiveRecord::Schema.define(version: 20140228210308) do

  create_table "justifications", force: true do |t|
    t.text     "reason"
    t.integer  "reservation_id"
    t.integer  "user_id"
    t.integer  "reservation_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "justifications", ["reservation_group_id"], name: "index_justifications_on_reservation_group_id"
  add_index "justifications", ["reservation_id"], name: "index_justifications_on_reservation_id"
  add_index "justifications", ["user_id"], name: "index_justifications_on_user_id"

  create_table "object_resources", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "place_objects", force: true do |t|
    t.integer "object_resource_id"
    t.integer "place_id"
  end

  create_table "place_sectors", force: true do |t|
    t.integer "sector_id"
    t.integer "place_id"
  end

  create_table "places", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "capacity"
    t.boolean  "reservable"
    t.integer  "room_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "places", ["room_type_id"], name: "index_places_on_room_type_id"

  create_table "reservation_groups", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.date     "date"
    t.time     "begin_time"
    t.time     "end_time"
    t.string   "status"
    t.text     "reason"
    t.integer  "reservation_group_id"
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["place_id"], name: "index_reservations_on_place_id"
  add_index "reservations", ["reservation_group_id"], name: "index_reservations_on_reservation_group_id"
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "room_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sectors", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "cpf"
    t.string   "role"
    t.integer  "sector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
