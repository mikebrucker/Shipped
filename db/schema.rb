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

ActiveRecord::Schema.define(version: 2018_09_19_031341) do

  create_table "boats", force: :cascade do |t|
    t.string "name"
    t.integer "max_containers"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_id"
    t.index ["profile_id"], name: "index_boats_on_profile_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.text "desc"
    t.string "origin"
    t.string "destination"
    t.decimal "cost"
    t.integer "containers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "fname"
    t.string "lname"
    t.string "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "boat_id"
    t.integer "job_id"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boat_id"], name: "index_schedules_on_boat_id"
    t.index ["job_id"], name: "index_schedules_on_job_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
