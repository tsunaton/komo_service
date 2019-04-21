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


ActiveRecord::Schema.define(version: 2019_02_04_060946) do

  create_table "available_halls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "funeral_hall_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    t.index ["funeral_hall_id"], name: "index_available_halls_on_funeral_hall_id"
    t.index ["user_id"], name: "index_available_halls_on_user_id"
  end

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "dispatching_fee_per_hour"
    t.bigint "funeral_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funeral_id"], name: "index_clients_on_funeral_id"
  end

  create_table "funeral_halls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "nearest_station"
    t.bigint "funeral_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    t.index ["funeral_id"], name: "index_funeral_halls_on_funeral_id"
  end

  create_table "funerals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number_of_people"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "confirmation"
    t.bigint "user_id"
    t.bigint "funeral_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funeral_id"], name: "index_machings_on_funeral_id"
    t.index ["user_id"], name: "index_machings_on_user_id"
  end

  create_table "shifts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "scheduled_from"
    t.datetime "scheduled_to"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shifts_on_user_id"
  end

  create_table "shifts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "scheduled_from"
    t.datetime "scheduled_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_shifts_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "mail"
    t.string "address"
    t.string "nearest_station"
    t.integer "user_type"
    t.string "password_digest"
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_type"
  end

  create_table "working_hours", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_working_hours_on_user_id"
  end

  add_foreign_key "available_halls", "funeral_halls"
  add_foreign_key "available_halls", "users"
  add_foreign_key "clients", "funerals"
  add_foreign_key "funeral_halls", "funerals"
  add_foreign_key "machings", "funerals"
  add_foreign_key "machings", "users"
  add_foreign_key "shifts", "users"
  add_foreign_key "working_hours", "users"
end
