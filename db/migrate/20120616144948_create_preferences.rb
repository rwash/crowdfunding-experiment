class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
	    t.string :group
	    t.boolean :flag, :default => false
	    t.boolean :finished_and_ready, :default => false
	    t.boolean :ready_to_start, :default => false
	    t.boolean :contributed, :default => false
	    t.boolean :timer_expired, :default => false
	    t.integer :round_payout, :default => 0
	    t.integer :user_id
	    t.integer :round_id
	    t.integer :kind_of
	    t.integer :a_payout, :default => 0
	    t.integer :b_payout, :default => 0
	    t.integer :c_payout, :default => 0
	    t.integer :d_payout, :default => 0

      t.timestamps
    end
  end
end
