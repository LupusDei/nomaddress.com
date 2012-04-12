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

ActiveRecord::Schema.define(:version => 20120412225032) do

  create_table "addresses", :force => true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "amazons", :force => true do |t|
    t.string   "email"
    t.string   "full_name"
    t.string   "country"
    t.string   "phone_number"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
  end

  add_index "amazons", ["address_id"], :name => "index_amazons_on_address_id"

  create_table "dmvs", :force => true do |t|
    t.string   "driver_license"
    t.string   "ssn"
    t.integer  "address_id"
    t.string   "county"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dmvs", ["address_id"], :name => "index_dmvs_on_address_id"

  create_table "ebays", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "phone_number"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "ebays", ["address_id"], :name => "index_ebays_on_address_id"

  create_table "subscribers", :force => true do |t|
    t.string   "name"
    t.string   "img_path"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subscribable_id"
    t.string   "subscribable_type"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "email"
    t.string   "fb_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "last_login_at"
    t.datetime "last_request_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "login_count",       :default => 0,         :null => false
    t.string   "status",            :default => "pending"
  end

end
