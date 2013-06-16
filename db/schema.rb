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

ActiveRecord::Schema.define(:version => 20130616044209) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "contributions", :force => true do |t|
    t.time     "time_contributed"
    t.integer  "amount"
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "group_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "creator_preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "is_ready",       :default => false
    t.boolean  "finished_round", :default => false
    t.integer  "round_id"
  end

  create_table "donor_preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "is_ready",       :default => false
    t.boolean  "finished_round", :default => false
    t.integer  "round_id"
    t.boolean  "special_donor",  :default => false
  end

  create_table "experiments", :force => true do |t|
    t.boolean  "return_credits",       :default => false
    t.boolean  "started",              :default => false
    t.boolean  "finished",             :default => false
    t.boolean  "finished_calc",        :default => false
    t.integer  "current_round_number", :default => 1
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "groups", :force => true do |t|
    t.integer  "round_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "goal_amount"
    t.integer  "total_contributions"
    t.integer  "group_id"
    t.string   "admin_name"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "value"
    t.string   "popularity"
    t.integer  "standard_return_amount"
    t.integer  "special_return_amount"
    t.integer  "user_id"
    t.integer  "special_user_1"
    t.integer  "special_user_2"
    t.boolean  "funded",                 :default => false
    t.integer  "number_donors"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "experiment_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "part_a_finished",  :default => false
    t.boolean  "part_a_started",   :default => false
    t.integer  "number"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "part_b_started",   :default => false
    t.boolean  "part_b_finished",  :default => false
    t.boolean  "round_complete",   :default => false
    t.boolean  "summary_complete", :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.integer  "payout",                    :default => 0
    t.integer  "questions_payout",          :default => 0
    t.string   "token"
    t.integer  "experiment_id"
    t.integer  "times_viewed_instructions"
    t.string   "persistence_token",                        :null => false
    t.string   "question_1A"
    t.string   "question_1B"
    t.integer  "question_2A"
    t.integer  "question_2B"
    t.integer  "question_2C"
    t.integer  "question_2D"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "user_type"
  end

end
