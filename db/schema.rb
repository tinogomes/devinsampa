# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091110181816) do

  create_table "agendas", :force => true do |t|
    t.binary   "start_time", :limit => 255
    t.binary   "end_time",   :limit => 255
    t.binary   "event",      :limit => 255
    t.integer  "speaker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agendas", ["start_time"], :name => "index_agendas_on_start_time"

  create_table "attendees", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "doc"
    t.string   "company"
    t.string   "status"
    t.string   "payment_method"
    t.datetime "processed_at"
    t.text     "buyer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "notes"
    t.string   "transaction_id"
  end

  add_index "attendees", ["token"], :name => "index_attendees_on_token"

  create_table "speakers", :force => true do |t|
    t.binary   "name",         :limit => 255
    t.binary   "bio"
    t.binary   "presentation", :limit => 255
    t.binary   "description"
    t.binary   "filename",     :limit => 255
    t.integer  "size"
    t.binary   "content_type", :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "email",        :limit => 255
  end

  add_index "speakers", ["name"], :name => "index_speakers_on_name"

  create_table "users", :force => true do |t|
    t.binary   "name",              :limit => 255
    t.binary   "username",          :limit => 255
    t.binary   "email",             :limit => 255
    t.binary   "crypted_password",  :limit => 255
    t.binary   "password_salt",     :limit => 255
    t.binary   "persistence_token", :limit => 255
    t.binary   "role",              :limit => 255, :default => "attendee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
