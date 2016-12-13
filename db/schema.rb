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

ActiveRecord::Schema.define(version: 20161120081915) do

  create_table "addresses", force: :cascade do |t|
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "business_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "company_name"
    t.integer  "business_type_id"
    t.text     "company_description"
    t.string   "logo"
    t.string   "sub_domain"
    t.string   "country"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "currency"
    t.decimal  "tax_rate",            precision: 8, scale: 2
    t.integer  "owner_id"
    t.integer  "integer"
    t.boolean  "status",                                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "low_stock_alert"
    t.string   "email"
    t.string   "phone"
    t.boolean  "is_activated",                                default: true
    t.string   "currency_name"
    t.string   "currency_code"
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "published",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
  end

  add_index "customers", ["company_id"], name: "index_customers_on_company_id"

  create_table "expenses", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "attachment"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "purpose"
    t.datetime "paid_time"
    t.string   "expense_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "low_stock_alert"
    t.float    "amount"
  end

  add_index "expenses", ["company_id"], name: "index_expenses_on_company_id"

  create_table "item_categories", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_categories", ["company_id"], name: "index_item_categories_on_company_id"

  create_table "items", force: :cascade do |t|
    t.string   "sku"
    t.string   "name"
    t.text     "description"
    t.decimal  "price",            precision: 8, scale: 2
    t.integer  "stock_amount"
    t.integer  "amount_sold",                              default: 0
    t.decimal  "cost_price",       precision: 8, scale: 2
    t.boolean  "published",                                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_category_id"
    t.integer  "company_id"
    t.string   "photo"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "quantity",                            default: 1
    t.decimal  "price",       precision: 8, scale: 2
    t.decimal  "total_price", precision: 8, scale: 2
    t.integer  "sale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.integer  "address_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "published",  default: true
  end

  create_table "locations_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "location_id"
  end

  add_index "locations_users", ["location_id"], name: "index_locations_users_on_location_id"
  add_index "locations_users", ["user_id"], name: "index_locations_users_on_user_id"

  create_table "payments", force: :cascade do |t|
    t.integer  "sale_id"
    t.decimal  "amount",       precision: 8, scale: 2
    t.string   "payment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.decimal  "amount",           precision: 8, scale: 2
    t.decimal  "total_amount",     precision: 8, scale: 2
    t.decimal  "remaining_amount"
    t.decimal  "discount",         precision: 8, scale: 2
    t.decimal  "tax",              precision: 8, scale: 2
    t.integer  "customer_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "logo"
    t.string   "url"
    t.string   "facebook_url"
    t.string   "google_url"
    t.string   "twitter_url"
    t.string   "map_url"
    t.text     "description"
    t.string   "email"
    t.string   "phone"
    t.string   "tag_line"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.string   "address"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "username",                 default: "",    null: false
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "photo"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",          default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "can_update_users",         default: false
    t.boolean  "can_update_items",         default: true
    t.boolean  "can_update_configuration", default: false
    t.boolean  "can_view_reports",         default: false
    t.boolean  "can_update_sale_discount", default: false
    t.boolean  "can_remove_sales",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "salary"
    t.string   "skills"
    t.integer  "role_id"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id"
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
