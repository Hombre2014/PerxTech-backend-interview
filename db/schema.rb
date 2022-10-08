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

ActiveRecord::Schema[7.0].define(version: 2022_10_06_140121) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "purchases", force: :cascade do |t|
    t.date "date"
    t.string "country_of_purchase"
    t.decimal "amount"
    t.boolean "counted"
    t.boolean "processed_for_points"
    t.boolean "checked_for_5_percent_rewards"
    t.boolean "checked_for_free_movie_tickets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "country_of_origin"
    t.integer "level"
    t.integer "points"
    t.string "tier"
    t.boolean "birthday_reward"
    t.decimal "total_amount_spent"
    t.decimal "total_amount_spent_foreign"
    t.decimal "unused_amount"
    t.decimal "unused_amount_foreign"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "purchases", "users"
  add_foreign_key "rewards", "users"
end
