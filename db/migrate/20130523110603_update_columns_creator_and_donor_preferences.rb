class UpdateColumnsCreatorAndDonorPreferences < ActiveRecord::Migration
  def up
    rename_column :creator_preferences, :creator_id, :user_id
    rename_column :donor_preferences, :donor_id, :user_id
  end

  def down
    rename_column :creator_preferences, :user_id, :creator_id
    rename_column :donor_preferences, :user_id, :donor_id
  end
end
