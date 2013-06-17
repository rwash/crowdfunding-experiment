class AddCreditsToBeReturnedToDonorPreferences < ActiveRecord::Migration
  def change
    add_column :donor_preferences, :credits_to_be_returned, :integer
  end
end
