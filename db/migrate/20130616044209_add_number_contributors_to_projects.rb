class AddNumberContributorsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :number_donors, :integer
  end
end
