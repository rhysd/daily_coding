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

ActiveRecord::Schema.define(:version => 20120709153427) do

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

  create_table "favs", :force => true do |t|
    t.integer  "answer_id",  :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favs", ["answer_id"], :name => "index_favs_on_answer_id"
  add_index "favs", ["user_id"], :name => "index_favs_on_user_id"

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
    t.string   "provider",            :null => false
    t.string   "uid",                 :null => false
    t.string   "nickname",            :null => false
    t.string   "email"
    t.string   "name"
    t.string   "image"
    t.string   "blog_url"
    t.string   "github_url",          :null => false
    t.string   "bio"
    t.integer  "followers"
    t.integer  "following"
    t.string   "oauth_token",         :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.datetime "remember_created_at"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["nickname"], :name => "index_users_on_nickname", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token", :unique => true
  add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true

end
