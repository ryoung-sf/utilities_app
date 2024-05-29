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

ActiveRecord::Schema[7.1].define(version: 2024_06_03_000434) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "authorizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "external_uid", null: false
    t.datetime "submitted_date", null: false
    t.string "customer_email", null: false
    t.jsonb "customer_signature"
    t.datetime "declined_date"
    t.datetime "expired_date"
    t.jsonb "exports_list"
    t.boolean "is_archived", default: false, null: false
    t.jsonb "notes"
    t.string "nickname"
    t.datetime "revoked_date"
    t.jsonb "scope"
    t.string "status"
    t.string "status_message"
    t.datetime "status_updated_date"
    t.string "utility", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "billing_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "utility_account_id", null: false
    t.string "contact_name"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "meter_id", null: false
    t.uuid "bill_id", null: false
    t.index ["bill_id"], name: "index_billing_accounts_on_bill_id"
    t.index ["meter_id"], name: "index_billing_accounts_on_meter_id"
    t.index ["user_id"], name: "index_billing_accounts_on_user_id"
  end

  create_table "bills", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "external_uid", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "total_kwh_times_100"
    t.string "total_unit"
    t.integer "total_volume_times_100"
    t.integer "total_cost_cents"
    t.string "raw_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "authorization_id", null: false
    t.index ["authorization_id"], name: "index_bills_on_authorization_id"
  end

  create_table "meters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "external_uid", null: false
    t.string "service_class"
    t.string "service_id", null: false
    t.string "service_tariff"
    t.datetime "created_date", null: false
    t.string "utility_meter_id", null: false
    t.datetime "status_date", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "authorization_id", null: false
    t.index ["authorization_id"], name: "index_meters_on_authorization_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "authorizations", "users"
  add_foreign_key "billing_accounts", "bills"
  add_foreign_key "billing_accounts", "meters"
  add_foreign_key "billing_accounts", "users"
  add_foreign_key "bills", "authorizations"
  add_foreign_key "meters", "authorizations"
end
