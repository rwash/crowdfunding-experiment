class AddColumnToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :value, :string
  end
  
  def down
    remove_column :projects, :value
  end
end
