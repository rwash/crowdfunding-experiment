class AddColumnsToCreatorAndDonorPreferences < ActiveRecord::Migration
  def up
    add_column :creator_preferences, :finished_round, :boolean, :default => false
    add_column :donor_preferences, :finished_round, :boolean, :default => false
  end
  
  def down
    remove_column :creator_preferences, :finished_round
    remove_column :donor_preferences, :finished_round
  end
end
