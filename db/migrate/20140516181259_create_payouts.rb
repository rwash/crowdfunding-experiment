class CreatePayouts < ActiveRecord::Migration
  def change
    create_table :payouts do |t|
      t.integer :round
      t.string :project_type
      t.string :project_name
      t.integer :user
      t.integer :condition
      t.integer :payout

      t.timestamps
    end
  end
end
