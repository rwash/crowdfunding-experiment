class AddSpecialUsersToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :special_user_1, :integer
    add_column :projects, :special_user_2, :integer
  end
end
