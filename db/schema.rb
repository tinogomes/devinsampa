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

ActiveRecord::Schema.define(:version => 20100717214323) do

  create_table "agendas", :force => true do |t|
    t.string   "start_time"
    t.string   "end_time"
    t.string   "event"
    t.integer  "presentation_id"
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
    t.boolean  "will_unregister", :default => false
  end

  add_index "attendees", ["token"], :name => "index_attendees_on_token"

  create_table "presentation_speakers", :force => true do |t|
    t.integer  "presentation_id"
    t.integer  "speaker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presentations", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "speakers", :force => true do |t|
    t.string   "name"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "twitter"
    t.string   "doc"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "speakers", ["name"], :name => "index_speakers_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "role",              :default => "attendee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
