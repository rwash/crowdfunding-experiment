class RenameColumnInProjects < ActiveRecord::Migration
  def up
    rename_column :projects, :funded_amount, :total_contributions
  end

  def down
    rename_column :projects, :total_contributions, :funded_amount
  end
end
