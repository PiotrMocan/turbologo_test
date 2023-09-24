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

ActiveRecord::Schema[7.0].define(version: 2023_09_24_113934) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advanced_metrics", force: :cascade do |t|
    t.boolean "slogan_exists"
    t.bigint "industry_id"
    t.boolean "icon_selected"
    t.bigint "template_name"
    t.integer "sales_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_advanced_metrics_on_industry_id"
    t.index ["template_name"], name: "index_advanced_metrics_on_template_name"
  end

  create_table "company_length_metrics", force: :cascade do |t|
    t.integer "min_length"
    t.integer "max_length"
    t.bigint "template_name"
    t.integer "sales_count"
    t.boolean "extended"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_name"], name: "index_company_length_metrics_on_template_name"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "template_stats", force: :cascade do |t|
    t.bigint "template_name"
    t.bigint "industry_id"
    t.integer "impressions_count"
    t.integer "clicks_count"
    t.integer "sales_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_template_stats_on_industry_id"
    t.index ["template_name"], name: "index_template_stats_on_template_name"
  end

  create_table "templates", force: :cascade do |t|
    t.string "preview_image"
    t.boolean "icon_required"
    t.boolean "slogan_required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
