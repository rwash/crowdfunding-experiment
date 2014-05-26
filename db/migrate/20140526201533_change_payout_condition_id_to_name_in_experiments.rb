class ChangePayoutConditionIdToNameInExperiments < ActiveRecord::Migration
  def change
    change_table :experiments do |t|
      t.remove :payout_condition_id
      t.string :payout_condition
    end
  end
end
