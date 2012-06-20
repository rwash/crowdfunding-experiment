class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
    	t.string :experiment_id
    	t.time :start_time
    	t.time :end_time
    	t.boolean :finished, :default => false
    	t.boolean :started, :default => false
    	t.integer :number

      t.timestamps
    end
  end
end
