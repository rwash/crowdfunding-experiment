class AddColumnsToCreatorPreferences < ActiveRecord::Migration
  def change
    add_column :creator_preferences, :total_return_from_projects, :integer
    add_column :creator_preferences, :credits_to_be_returned, :integer
  end
end
