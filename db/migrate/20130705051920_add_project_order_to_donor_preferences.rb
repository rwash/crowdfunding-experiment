class AddProjectOrderToDonorPreferences < ActiveRecord::Migration
  
  def change
    add_column :donor_preferences, :project_display_order, :string
  end

end
