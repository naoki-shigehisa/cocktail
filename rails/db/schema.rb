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

ActiveRecord::Schema.define(version: 2021_05_30_040234) do

  create_table "alcohols", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "materials", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "alcohol_flag", default: false, null: false
    t.boolean "have_flag", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.string "name_entered"
    t.boolean "done_flag", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_orders_on_recipe_id"
  end

  create_table "recipe_materials", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "material_id", null: false
    t.string "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "option_flag", default: false, null: false
    t.boolean "base_flag", default: false, null: false
    t.index ["material_id"], name: "fk_rails_8d34a49dfe"
    t.index ["recipe_id"], name: "fk_rails_cf55153585"
  end

  create_table "recipes", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "style_id", null: false
    t.bigint "tech_id", null: false
    t.bigint "alcohol_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["alcohol_id"], name: "fk_rails_fbd57f879a"
    t.index ["style_id"], name: "fk_rails_9754ad668b"
    t.index ["tech_id"], name: "fk_rails_8c8778d2c9"
  end

  create_table "reviews", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "assessment", default: 0, null: false
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "recipe_id", null: false
    t.index ["recipe_id"], name: "index_reviews_on_recipe_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "styles", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teches", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "orders", "recipes"
  add_foreign_key "recipe_materials", "materials"
  add_foreign_key "recipe_materials", "recipes"
  add_foreign_key "recipes", "alcohols"
  add_foreign_key "recipes", "styles"
  add_foreign_key "recipes", "teches"
  add_foreign_key "reviews", "recipes"
end
