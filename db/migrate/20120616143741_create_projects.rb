class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
	    t.string :name
	    t.integer :goal_ammount
	    t.integer :start_ammount
	    t.integer :current_amount
	    t.string :group
	    t.integer :round_id

      t.timestamps
    end
  end
end
