class DropColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :creator_id
    remove_column :users, :donor_id
  end

  def down
    add_column :users, :creator_id, :integer
    add_column :users, :donor_id, :integer
  end
end
