# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_15_040054) do

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "fname", default: "", null: false
    t.string "lname", default: "", null: false
    t.string "image", default: "", null: false
    t.string "password", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
