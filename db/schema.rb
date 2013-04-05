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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130405181448) do

  create_table "camps", :force => true do |t|
    t.string   "camp_type"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "location"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reservations", :force => true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "phone"
    t.text     "address"
    t.string   "email"
    t.string   "emergency_contact"
    t.boolean  "insurance"
    t.string   "medical_provider"
    t.string   "parental_consent_signature"
    t.string   "hold_harmless_signature"
    t.string   "guardian_signature"
    t.date     "date_signed"
    t.date     "camp_start_date"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.boolean  "paid"
    t.string   "confirmation_id"
    t.string   "camp_type"
    t.float    "camp_price"
    t.string   "camp_location"
    t.float    "balance"
    t.integer  "camp_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "salt"
    t.string   "crypted_password"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
