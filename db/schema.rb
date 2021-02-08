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

ActiveRecord::Schema.define(version: 2021_02_05_143219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "banners", force: :cascade do |t|
    t.string "name"
    t.integer "link_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "link_type"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.integer "amount"
    t.datetime "valid_from"
    t.datetime "valid_till"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.string "discount_type"
    t.decimal "amount"
    t.datetime "valid_from"
    t.datetime "valid_till"
    t.string "discountable_type", null: false
    t.bigint "discountable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discountable_type", "discountable_id"], name: "index_discounts_on_discountable_type_and_discountable_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "sub_total"
    t.string "token"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "product_variant_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_variant_id"], name: "index_notifications_on_product_variant_id"
  end

  create_table "ordered_items", force: :cascade do |t|
    t.integer "product_variant_id"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.bigint "order_id"
    t.decimal "subtotal", precision: 8, scale: 2, null: false
    t.decimal "purchase_price", precision: 8, scale: 2, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "total", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.decimal "total_purchase_price"
    t.decimal "coupon_discount", default: "0.0"
    t.integer "status", default: 0, null: false
    t.boolean "in_cart"
  end

  create_table "product_variants", force: :cascade do |t|
    t.text "details"
    t.decimal "price", precision: 8, scale: 2, null: false
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "in_stock"
    t.decimal "purchase_price", precision: 8, scale: 2, null: false
    t.boolean "featured", default: false
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.bigint "sub_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_id"
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "order_id"
    t.string "full_name"
    t.string "email"
    t.string "phone"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "payment_option"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "title"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.string "contact"
    t.integer "role", default: 0
    t.string "address"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "notifications", "product_variants"
end
