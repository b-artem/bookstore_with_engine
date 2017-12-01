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

ActiveRecord::Schema.define(version: 20171105162159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["order_id"], name: "index_addresses_on_order_id"
    t.index ["type"], name: "index_addresses_on_type"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", force: :cascade do |t|
    t.bigint "author_id"
    t.bigint "book_id"
    t.index ["author_id"], name: "index_authors_books_on_author_id"
    t.index ["book_id"], name: "index_authors_books_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.decimal "price", precision: 7, scale: 2
    t.integer "publication_year"
    t.string "dimensions"
    t.string "materials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books_categories", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "category_id"
    t.index ["book_id"], name: "index_books_categories_on_book_id"
    t.index ["category_id"], name: "index_books_categories_on_category_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coupon_id"
    t.index ["coupon_id"], name: "index_carts_on_coupon_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.decimal "discount", precision: 4, scale: 1
    t.date "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.bigint "book_id"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_images_on_book_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.bigint "order_id"
    t.decimal "price", precision: 7, scale: 2
    t.index ["book_id"], name: "index_line_items_on_book_id"
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "number"
    t.datetime "completed_at"
    t.string "state"
    t.bigint "user_id"
    t.bigint "shipping_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "use_billing_address_as_shipping", default: false
    t.bigint "coupon_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["number"], name: "index_orders_on_number"
    t.index ["shipping_method_id"], name: "index_orders_on_shipping_method_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.integer "score"
    t.string "status"
    t.bigint "book_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shipping_methods", force: :cascade do |t|
    t.string "name"
    t.integer "days_min"
    t.integer "days_max"
    t.float "price"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user"
    t.string "omniauth_provider"
    t.string "omniauth_uid"
    t.string "image_url"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["omniauth_provider", "omniauth_uid"], name: "index_users_on_omniauth_provider_and_omniauth_uid", unique: true
    t.index ["omniauth_provider"], name: "index_users_on_omniauth_provider"
    t.index ["omniauth_uid"], name: "index_users_on_omniauth_uid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "orders"
  add_foreign_key "addresses", "users"
  add_foreign_key "authors_books", "authors"
  add_foreign_key "authors_books", "books"
  add_foreign_key "books_categories", "books"
  add_foreign_key "books_categories", "categories"
  add_foreign_key "carts", "coupons"
  add_foreign_key "images", "books"
  add_foreign_key "line_items", "books"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "orders"
  add_foreign_key "orders", "coupons"
  add_foreign_key "orders", "shipping_methods"
  add_foreign_key "orders", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
