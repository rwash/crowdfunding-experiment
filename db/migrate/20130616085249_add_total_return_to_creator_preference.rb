class AddTotalReturnToCreatorPreference < ActiveRecord::Migration
  def change
    add_column :creator_preferences, :total_return, :integer
    add_column :donor_preferences, :total_return, :integer   
  end
end
