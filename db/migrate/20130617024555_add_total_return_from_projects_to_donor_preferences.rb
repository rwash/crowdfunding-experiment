class AddTotalReturnFromProjectsToDonorPreferences < ActiveRecord::Migration
  def change
    add_column :donor_preferences, :total_return_from_projects, :integer

  end
end
