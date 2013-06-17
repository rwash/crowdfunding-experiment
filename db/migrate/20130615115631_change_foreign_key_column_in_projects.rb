class ChangeForeignKeyColumnInProjects < ActiveRecord::Migration
  def up
    rename_column :projects, :round_id, :group_id
  end

  def down
    rename_column :projects, :group_id, :round_id  
  end
end
