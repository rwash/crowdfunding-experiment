class AddFundedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :funded, :boolean, :default => false
  end
end
