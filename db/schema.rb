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

ActiveRecord::Schema[7.0].define(version: 2022_11_09_035944) do
  create_table "guest_contacts", force: :cascade do |t|
    t.integer "guest_id", null: false
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_guest_contacts_on_guest_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.string "code"
    t.date "start_date"
    t.date "end_date"
    t.integer "number_of_nights"
    t.integer "number_of_guests"
    t.integer "number_of_children"
    t.integer "number_of_infants"
    t.integer "number_of_adults"
    t.string "description"
    t.string "status"
    t.string "host_currency"
    t.decimal "payout_price"
    t.decimal "security_price"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guest_id"
    t.index ["code"], name: "index_reservations_on_code", unique: true
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
  end

  add_foreign_key "guest_contacts", "guests"
end
