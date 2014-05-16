class AddPreferenceTypeToDonorPreferences < ActiveRecord::Migration
  def change
    add_column :donor_preferences, :preference_type, :integer

  end
end
