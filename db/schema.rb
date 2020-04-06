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

ActiveRecord::Schema.define(version: 2020_04_06_125634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "menuitems", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.bigint "menu_id", null: false
    t.index ["menu_id"], name: "index_menuitems_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
  end

  create_table "orderitems", force: :cascade do |t|
    t.string "menu_item_name"
    t.float "menu_item_price"
    t.bigint "order_id", null: false
    t.bigint "menuitem_id", null: false
    t.index ["menuitem_id"], name: "index_orderitems_on_menuitem_id"
    t.index ["order_id"], name: "index_orderitems_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "date"
    t.datetime "delivered_at"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "role"
  end

  add_foreign_key "menuitems", "menus"
  add_foreign_key "orderitems", "menuitems"
  add_foreign_key "orderitems", "orders"
  add_foreign_key "orders", "users"
end
