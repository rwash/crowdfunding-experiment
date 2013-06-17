class AddDefaultToExperiments < ActiveRecord::Migration

  def up 
    change_column :experiments, :current_round_number, :integer, :default => 1
  end

  def down 
    change_column :experiments, :current_round_number, :integer, :default => 0
  end

end
