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

ActiveRecord::Schema.define(version: 2022_06_23_083624) do

  create_table "accounts", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "iban", null: false
    t.string "currency", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_accounts_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.text "email", null: false
    t.text "password", null: false
    t.text "full_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_orders", force: :cascade do |t|
    t.integer "issuer_id", null: false
    t.integer "receiver_id", null: false
    t.integer "amount", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["issuer_id"], name: "index_payment_orders_on_issuer_id"
    t.index ["receiver_id"], name: "index_payment_orders_on_receiver_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id", null: false
    t.datetime "executed_at"
    t.integer "source_id", null: false
    t.integer "target_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["source_id"], name: "index_payments_on_source_id"
    t.index ["target_id"], name: "index_payments_on_target_id"
  end

  add_foreign_key "accounts", "customers"
  add_foreign_key "payment_orders", "customers", column: "issuer_id"
  add_foreign_key "payment_orders", "customers", column: "receiver_id"
  add_foreign_key "payments", "accounts", column: "source_id"
  add_foreign_key "payments", "accounts", column: "target_id"
  add_foreign_key "payments", "payment_orders", column: "order_id"
end
