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

ActiveRecord::Schema.define(version: 20171119124954) do

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.decimal "price", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_addresses", force: :cascade do |t|
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["order_id"], name: "index_shopping_cart_addresses_on_order_id"
    t.index ["type"], name: "index_shopping_cart_addresses_on_type"
    t.index ["user_id"], name: "index_shopping_cart_addresses_on_user_id"
  end

  create_table "shopping_cart_carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coupon_id"
    t.index ["coupon_id"], name: "index_shopping_cart_carts_on_coupon_id"
  end

  create_table "shopping_cart_coupons", force: :cascade do |t|
    t.string "code"
    t.decimal "discount", precision: 4, scale: 1
    t.date "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_line_items", force: :cascade do |t|
    t.integer "product_id"
    t.integer "cart_id"
    t.integer "quantity", default: 1
    t.decimal "price", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["order_id"], name: "index_shopping_cart_line_items_on_order_id"
  end

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.string "number"
    t.datetime "completed_at"
    t.string "state"
    t.integer "user_id"
    t.integer "shipping_method_id"
    t.boolean "use_billing_address_as_shipping", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coupon_id"
    t.index ["coupon_id"], name: "index_shopping_cart_orders_on_coupon_id"
    t.index ["number"], name: "index_shopping_cart_orders_on_number"
    t.index ["shipping_method_id"], name: "index_shopping_cart_orders_on_shipping_method_id"
    t.index ["user_id"], name: "index_shopping_cart_orders_on_user_id"
  end

  create_table "shopping_cart_shipping_methods", force: :cascade do |t|
    t.string "name"
    t.integer "days_min"
    t.integer "days_max"
    t.decimal "price", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
