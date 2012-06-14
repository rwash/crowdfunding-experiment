class AddRoundToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :round_id, :integer
  end
end
