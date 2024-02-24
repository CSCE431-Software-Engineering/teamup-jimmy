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

ActiveRecord::Schema[7.0].define(version: 2024_02_23_203413) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "activity_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_preferences", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.string "student_email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "experience_level"
    t.index ["activity_id"], name: "index_activity_preferences_on_activity_id"
  end

  create_table "gym_preferences", force: :cascade do |t|
    t.string "student_email", null: false
    t.integer "gym_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gyms", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.string "student1_email", null: false
    t.string "student2_email", null: false
    t.string "relation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", primary_key: "email", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender_pref"
    t.integer "age_start_pref"
    t.integer "age_end_pref"
    t.string "phone_number"
    t.string "major"
    t.integer "grad_year"
    t.boolean "is_private"
    t.string "instagram_url"
    t.string "x_url"
    t.string "snap_url"
    t.string "profile_picture_url"
  end

  create_table "time_preferences", force: :cascade do |t|
    t.string "student_email", null: false
    t.time "time_start"
    t.time "time_end"
    t.string "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activity_preferences", "activities"
  add_foreign_key "activity_preferences", "students", column: "student_email", primary_key: "email"
  add_foreign_key "gym_preferences", "students", column: "student_email", primary_key: "email"
  add_foreign_key "matches", "students", column: "student1_email", primary_key: "email"
  add_foreign_key "matches", "students", column: "student2_email", primary_key: "email"
  add_foreign_key "time_preferences", "students", column: "student_email", primary_key: "email"
end
