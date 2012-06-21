class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.boolean :condition, :default => false
      t.boolean :started, :default => false
      t.boolean :finished, :default => false
      t.boolean :finsihed_calc, :default => false
      t.integer :current_round
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
