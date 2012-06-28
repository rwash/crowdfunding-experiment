class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.boolean :return_credits, :default => false
      t.boolean :started, :default => false
      t.boolean :finished, :default => false
      t.boolean :finsihed_calc, :default => false
      t.integer :current_round_number, :default => 0
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
