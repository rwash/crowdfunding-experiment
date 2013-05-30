class RenameColumnInCreatorAndDonorPreferences < ActiveRecord::Migration
  def up
    rename_column :creator_preferences, :ready_to_start, :is_ready
    rename_column :donor_preferences, :ready_to_start, :is_ready
  end

  def down
    rename_column :creator_preferences, :is_ready, :ready_to_start
    rename_column :donor_preferences, :is_ready, :ready_to_start
  end
end
