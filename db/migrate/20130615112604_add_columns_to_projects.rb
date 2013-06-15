class AddColumnsToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :standard_return_amount, :integer
    add_column :projects, :special_return_amount, :integer
    remove_column :projects, :start_amount
  end  
  
  def down
    remove_column :projects, :standard_return_amount
    remove_column :projects, :special_return_amount
    add_column :projects, :start_amount, :integer
  end
end
