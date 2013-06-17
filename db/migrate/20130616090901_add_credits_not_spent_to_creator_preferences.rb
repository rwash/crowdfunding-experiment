class AddCreditsNotSpentToCreatorPreferences < ActiveRecord::Migration
  def change
    add_column :creator_preferences, :credits_not_spent, :integer
    add_column :donor_preferences, :credits_not_donated, :integer
  end
end
