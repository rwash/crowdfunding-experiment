class AddCreatorEarningsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :creator_earnings, :integer
  end
end
