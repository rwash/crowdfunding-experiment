class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
	    t.string :name
	    t.integer :goal_amount
	    t.integer :start_amount
	    t.integer :funded_amount
	    t.string :group
	    t.integer :round_id

      t.timestamps
    end
  end
end
