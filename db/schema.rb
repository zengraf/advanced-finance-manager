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

ActiveRecord::Schema.define(version: 2021_06_19_113922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.decimal "amount", precision: 20, scale: 2
    t.bigint "currency_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "monobank_id"
    t.index ["currency_id"], name: "index_accounts_on_currency_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "limit", precision: 20, scale: 2
    t.index ["user_id"], name: "index_areas_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "limit", precision: 20, scale: 2
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "currencies_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "currency_id", null: false
  end

  create_table "currency_rates", id: false, force: :cascade do |t|
    t.integer "from_id", null: false
    t.integer "to_id", null: false
    t.string "source"
    t.decimal "rate", precision: 14, scale: 4, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_currency_rates_on_created_at"
    t.index ["from_id", "to_id"], name: "index_currency_rates_on_from_id_and_to_id"
  end

  create_table "loans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.decimal "interest", precision: 10, scale: 6
    t.datetime "deadline"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "loans_transactions", id: false, force: :cascade do |t|
    t.bigint "transaction_id", null: false
    t.bigint "loan_id", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount", precision: 20, scale: 2
    t.datetime "date"
    t.bigint "category_id", null: false
    t.bigint "area_id", null: false
    t.bigint "account_id", null: false
    t.integer "destination_account_id"
    t.decimal "destination_amount", precision: 20, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "monobank_id"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["area_id"], name: "index_transactions_on_area_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "jti", null: false
    t.bigint "primary_currency_id", null: false
    t.string "monobank_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "wishes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "amount", precision: 20, scale: 2
    t.bigint "currency_id", null: false
    t.string "description"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_id"], name: "index_wishes_on_currency_id"
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

  add_foreign_key "accounts", "currencies"
  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "areas", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "loans", "users"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "areas"
  add_foreign_key "transactions", "categories"
  add_foreign_key "wishes", "currencies"
  add_foreign_key "wishes", "users"
end
