class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
	    t.string :group
	    t.boolean :flag, :default => false
	    t.boolean :ready, :default => false
	    t.boolean :contributed, :default => false
	    t.boolean :timer_expired, :default => false
	    t.integer :payout
	    t.integer :user_id
	    t.integer :round_id
	    t.integer :kind_of

      t.timestamps
    end
  end
end
