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

ActiveRecord::Schema.define(version: 20170117211827) do

  create_table "stocks", force: :cascade do |t|
    t.string  "symbol"
    t.string  "name"
    t.integer "shares"
    t.decimal "price"
    t.string  "user"
  end

  create_table "transactions", force: :cascade do |t|
    t.string  "transaction_type"
    t.string  "date"
    t.string  "symbol"
    t.integer "shares"
    t.decimal "price"
    t.string  "user"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.float  "bank"
  end

end
