class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
	    t.string :group
	    t.boolean :flag, :default => false
	    t.boolean :ready, :default => false
	    t.boolean :contributed, :default => false
	    t.boolean :timer_expired, :default => false
	    t.integer :round_payout
	    t.integer :user_id
	    t.integer :round_id
	    t.integer :kind_of
	    t.integer :a_payout
	    t.integer :b_payout
	    t.integer :c_payout
	    t.integer :d_payout

      t.timestamps
    end
  end
end
