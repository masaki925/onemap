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

ActiveRecord::Schema.define(:version => 20130503080859) do

  create_table "areas", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "code",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "country_code", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "planday_spots", :force => true do |t|
    t.integer  "planday_id", :null => false
    t.integer  "spot_id",    :null => false
    t.integer  "position",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "planday_spots", ["planday_id"], :name => "index_planday_spots_on_planday_id"
  add_index "planday_spots", ["spot_id"], :name => "index_planday_spots_on_spot_id"

  create_table "plandays", :force => true do |t|
    t.integer  "plan_id",    :null => false
    t.integer  "day",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plandays", ["plan_id"], :name => "index_plandays_on_plan_id"

  create_table "plans", :force => true do |t|
    t.string   "title",                        :null => false
    t.integer  "user_id",                      :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "valid_f",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "spots", :force => true do |t|
    t.string   "name",             :null => false
    t.string   "google_reference"
    t.string   "address"
    t.string   "tel"
    t.string   "station"
    t.integer  "take_time"
    t.float    "cost"
    t.string   "lat"
    t.string   "lng"
    t.string   "site_url"
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"

end
