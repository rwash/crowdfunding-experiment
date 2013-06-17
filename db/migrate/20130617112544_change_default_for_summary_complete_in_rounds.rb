class ChangeDefaultForSummaryCompleteInRounds < ActiveRecord::Migration
  def up
    change_column :rounds, :summary_complete, :boolean, :default => false
  end

  def down
    change_column :rounds, :summary_complete, :boolean
  end
end
