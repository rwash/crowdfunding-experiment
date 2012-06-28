class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
    	t.string :group_id
    	t.datetime :start_time
    	t.datetime :end_time
    	t.boolean :finished, :default => false
    	t.boolean :started, :default => false
    	t.integer :number

      t.timestamps
    end
  end
end
