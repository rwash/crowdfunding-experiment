class RemoveCreditsToBeReturnedFromCreatorPreferences < ActiveRecord::Migration
  def up
    remove_column :creator_preferences, :credits_to_be_returned
  end

  def down
    add_column :creator_preferences, :credits_to_be_returned, :integer
  end
end
