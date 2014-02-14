class AddPayoutConditionIdExperiments < ActiveRecord::Migration
  def up
    add_column :experiments, :payout_condition_id, :integer
  end

  def down
    remove_column :experiments, :payout_condition_id
  end
end
