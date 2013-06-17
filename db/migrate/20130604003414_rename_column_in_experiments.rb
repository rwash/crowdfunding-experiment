class RenameColumnInExperiments < ActiveRecord::Migration
  def up
    rename_column :experiments, :finsihed_calc, :finished_calc
  end

  def down
    rename_column :experiments, :finished_calc, :finsihed_calc
  end
end
