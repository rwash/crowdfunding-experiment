class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
	    t.time :time_contributed
	    t.integer :ammount
	    t.integer :user_id
	    t.integer :project_id
	    t.integer :round_id

      t.timestamps
    end
  end
end
