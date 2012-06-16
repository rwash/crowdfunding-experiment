class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
    	t.string :session_id
    	t.time :start_time
    	t.time :end_time
    	t.boolean :finished, :default => false
    	t.boolean :started, :default => false

      t.timestamps
    end
  end
end
