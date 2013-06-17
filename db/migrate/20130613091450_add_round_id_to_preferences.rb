class AddRoundIdToPreferences < ActiveRecord::Migration
  def up
    add_column :creator_preferences, :round_id, :integer
    add_column :donor_preferences, :round_id, :integer
  end

  def down
    remove_column :creator_preferences, :round_id
    remove_column :donor_preferences, :round_id
  end

end
