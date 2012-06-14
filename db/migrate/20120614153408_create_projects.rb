class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :start_ammount
      t.integer :goal_ammount
      t.integer :current_amount

      t.timestamps
    end
  end
end
