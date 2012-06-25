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

ActiveRecord::Schema.define(:version => 20120616144948) do

  create_table "contributions", :force => true do |t|
    t.time     "time_contributed"
    t.integer  "amount"
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "round_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "experiments", :force => true do |t|
    t.boolean  "return_credits", :default => false
    t.boolean  "started",        :default => false
    t.boolean  "finished",       :default => false
    t.boolean  "finsihed_calc",  :default => false
    t.integer  "current_round"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "preferences", :force => true do |t|
    t.string   "group"
    t.boolean  "flag",               :default => false
    t.boolean  "finished_and_ready", :default => false
    t.boolean  "ready_to_start",     :default => false
    t.boolean  "contributed",        :default => false
    t.boolean  "timer_expired",      :default => false
    t.integer  "round_payout",       :default => 0
    t.integer  "user_id"
    t.integer  "round_id"
    t.integer  "kind_of"
    t.integer  "a_payout",           :default => 0
    t.integer  "b_payout",           :default => 0
    t.integer  "c_payout",           :default => 0
    t.integer  "d_payout",           :default => 0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "goal_amount"
    t.integer  "start_amount"
    t.integer  "funded_amount"
    t.string   "group"
    t.integer  "round_id"
    t.string   "admin_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "rounds", :force => true do |t|
    t.string   "experiment_id"
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "finished",      :default => false
    t.boolean  "started",       :default => false
    t.integer  "number"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.integer  "payout"
    t.string   "token"
    t.integer  "experiment_id"
    t.integer  "times_viewed_instructions"
    t.string   "persistence_token",         :null => false
    t.string   "question_1A"
    t.string   "question_1B"
    t.integer  "question_2A"
    t.integer  "question_2B"
    t.integer  "question_2C"
    t.integer  "question_2D"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
