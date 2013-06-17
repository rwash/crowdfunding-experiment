class AddSpecialDonorToDonorPreferences < ActiveRecord::Migration
  def change
    add_column :donor_preferences, :special_donor, :boolean, :default => false
  end
end
