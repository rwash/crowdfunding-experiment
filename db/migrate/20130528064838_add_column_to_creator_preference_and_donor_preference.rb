class AddColumnToCreatorPreferenceAndDonorPreference < ActiveRecord::Migration
  def change
    add_column :creator_preferences, :ready_to_start, :boolean, :default => false
    add_column :donor_preferences, :ready_to_start, :boolean, :default => false
  end
end
