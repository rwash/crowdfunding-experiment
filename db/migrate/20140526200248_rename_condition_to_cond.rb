class RenameConditionToCond < ActiveRecord::Migration
  def change
    change_table :payouts do |t| 
      t.remove :condition
      t.string :condition_name
    end
  end
end
