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

ActiveRecord::Schema.define(:version => 20120711153524) do

  create_table "answers", :force => true do |t|
    t.string   "url",        :null => false
    t.string   "lang",       :null => false
    t.text     "body",       :null => false
    t.integer  "user_id",    :null => false
    t.integer  "problem_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "answers", ["problem_id"], :name => "index_answers_on_problem_id"
  add_index "answers", ["url"], :name => "index_answers_on_url"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "provider",      :null => false
    t.string   "uid",           :null => false
    t.string   "screen_name",   :null => false
    t.string   "name"
    t.string   "access_token",  :null => false
    t.string   "access_secret"
    t.string   "bio"
    t.string   "image_url",     :null => false
    t.string   "web_url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "authentications", ["screen_name"], :name => "index_authentications_on_screen_name"
  add_index "authentications", ["uid"], :name => "index_authentications_on_uid"
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "favs", :force => true do |t|
    t.integer  "answer_id",  :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favs", ["user_id", "answer_id"], :name => "index_favs_on_user_id_and_answer_id", :unique => true

  create_table "problems", :force => true do |t|
    t.text     "content",                        :null => false
    t.string   "url"
    t.boolean  "proposed",    :default => false, :null => false
    t.date     "proposed_at",                    :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "problems", ["proposed"], :name => "index_problems_on_proposed"

  create_table "users", :force => true do |t|
    t.datetime "remember_created_at"
    t.string   "remember_token"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token", :unique => true

end
