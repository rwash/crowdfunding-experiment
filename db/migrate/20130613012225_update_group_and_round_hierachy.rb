class UpdateGroupAndRoundHierachy < ActiveRecord::Migration
  def up                 
    rename_column :rounds, :group_id, :experiment_id
    rename_column :groups, :experiment_id, :round_id
    rename_column :projects, :round_id, :group_id
    remove_column :projects, :group
    remove_column :users, :group_id
    rename_column :contributions, :round_id, :group_id
    rename_column :creator_preferences, :round_id, :group_id
    rename_column :donor_preferences, :round_id, :group_id
  end

  def down            
    rename_column :rounds, :experiment_id, :group_id
    rename_column :groups, :round_id, :experiment_id
    rename_column :projects, :group_id, :round_id
    add_column :projects, :group, :string
    add_column :users, :group_id, :integer
    rename_column :contributions, :group_id, :round_id
    rename_column :creator_preferences, :group_id, :round_id
    rename_column :donor_preferences, :group_id, :round_id
  end
end
