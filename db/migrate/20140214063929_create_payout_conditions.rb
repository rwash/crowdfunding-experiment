class CreatePayoutConditions < ActiveRecord::Migration
  def change
    create_table :payout_conditions do |t|
      t.string :name
      t.text :data
      t.timestamps
    end
  end
end
