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

ActiveRecord::Schema.define(:version => 20140526201533) do

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
    t.integer  "amount"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "creator_preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "is_ready",                   :default => false
    t.boolean  "finished_round",             :default => false
    t.integer  "round_id"
    t.integer  "total_return"
    t.integer  "credits_not_spent"
    t.integer  "total_return_from_projects"
  end

  create_table "donor_preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "is_ready",                   :default => false
    t.boolean  "finished_round",             :default => false
    t.integer  "round_id"
    t.integer  "total_return"
    t.integer  "credits_not_donated"
    t.integer  "total_return_from_projects"
    t.integer  "credits_to_be_returned"
    t.string   "project_display_order"
    t.integer  "preference_type"
  end

  create_table "experiments", :force => true do |t|
    t.boolean  "return_credits",       :default => false
    t.boolean  "started",              :default => false
    t.boolean  "finished",             :default => false
    t.integer  "current_round_number", :default => 1
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "payout_condition"
  end

  create_table "groups", :force => true do |t|
    t.integer  "round_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payout_conditions", :force => true do |t|
    t.string   "name"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payouts", :force => true do |t|
    t.integer  "round"
    t.string   "project_type"
    t.string   "project_name"
    t.integer  "user"
    t.integer  "payout"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "condition_name"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "goal_amount"
    t.integer  "total_contributions"
    t.integer  "group_id"
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
    t.integer  "creator_earnings"
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
    t.string   "round_type"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "survey_complete", :default => false
    t.integer  "q1"
    t.string   "q2"
    t.boolean  "q3"
    t.string   "q4"
    t.boolean  "q5"
    t.boolean  "q6"
    t.string   "q7_a"
    t.string   "q7_b"
    t.boolean  "q8"
    t.string   "q9"
    t.string   "q10"
    t.string   "q11"
    t.string   "q12_a"
    t.string   "q12_b"
    t.string   "q12_c"
    t.string   "q12_d"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "token"
    t.integer  "experiment_id"
    t.integer  "times_viewed_instructions"
    t.string   "persistence_token",         :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "user_type"
    t.integer  "total_return"
    t.integer  "total_return_in_dollars"
    t.string   "status"
  end

end
