class CreateSession < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.boolean :condition, :default => false
      t.boolean :started, :default => false
      t.integer :current_round
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
