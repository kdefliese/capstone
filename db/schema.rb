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

ActiveRecord::Schema.define(version: 20160224220633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: :cascade do |t|
    t.string   "brand"
    t.string   "product_name"
    t.string   "ingredients_list",                array: true
    t.string   "manufacturer"
    t.string   "category"
    t.string   "ean13"
    t.string   "upc"
    t.string   "factual_id"
    t.string   "image_urls"
    t.string   "sensitivity_groups",              array: true
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "foods_ingredients", id: false, force: :cascade do |t|
    t.integer "food_id"
    t.integer "ingredient_id"
  end

  add_index "foods_ingredients", ["food_id"], name: "index_foods_ingredients_on_food_id", using: :btree
  add_index "foods_ingredients", ["ingredient_id"], name: "index_foods_ingredients_on_ingredient_id", using: :btree

  create_table "foods_meals", id: false, force: :cascade do |t|
    t.integer "food_id"
    t.integer "meal_id"
  end

  add_index "foods_meals", ["food_id"], name: "index_foods_meals_on_food_id", using: :btree
  add_index "foods_meals", ["meal_id"], name: "index_foods_meals_on_meal_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.string   "sensitivity_groups",              array: true
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "ingredients_meals", id: false, force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "meal_id"
  end

  add_index "ingredients_meals", ["ingredient_id"], name: "index_ingredients_meals_on_ingredient_id", using: :btree
  add_index "ingredients_meals", ["meal_id"], name: "index_ingredients_meals_on_meal_id", using: :btree

  create_table "meals", force: :cascade do |t|
    t.string   "name"
    t.string   "foods_list",                    array: true
    t.string   "ingredients_list",              array: true
    t.string   "category"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "email"
    t.integer  "phone"
    t.string   "name"
    t.string   "image"
    t.string   "known_intolerances"
    t.string   "watching"
    t.string   "medical_disorders"
    t.boolean  "notifications_preference", default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

end
