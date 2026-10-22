# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_20_235435) do
  create_table "drivers", force: :cascade do |t|
    t.string "name", null: false
    t.string "cnh", null: false
    t.date "cnh_expiration", null: false
    t.integer "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cnh"], name: "index_drivers_on_cnh", unique: true
    t.index ["vehicle_id"], name: "index_drivers_on_vehicle_id"
  end

  create_table "fuelings", force: :cascade do |t|
    t.integer "vehicle_id", null: false
    t.date "date", null: false
    t.decimal "liters", precision: 8, scale: 2, null: false
    t.decimal "cost", precision: 10, scale: 2, null: false
    t.integer "odometer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_fuelings_on_vehicle_id"
  end

  create_table "maintenance_orders", force: :cascade do |t|
    t.integer "vehicle_id", null: false
    t.integer "kind", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.date "opened_at", null: false
    t.date "scheduled_for"
    t.integer "odometer"
    t.date "released_at"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_maintenance_orders_on_vehicle_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "vehicle_id", null: false
    t.integer "driver_id", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.integer "distance_km"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate", null: false
    t.string "model", null: false
    t.integer "year", null: false
    t.string "kind", null: false
    t.integer "status", default: 0, null: false
    t.integer "odometer", default: 0, null: false
    t.date "crlv_expiration"
    t.date "insurance_expiration"
    t.date "ipva_expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plate"], name: "index_vehicles_on_plate", unique: true
  end

  add_foreign_key "drivers", "vehicles"
  add_foreign_key "fuelings", "vehicles"
  add_foreign_key "maintenance_orders", "vehicles"
  add_foreign_key "sessions", "users"
  add_foreign_key "trips", "drivers"
  add_foreign_key "trips", "vehicles"
end
