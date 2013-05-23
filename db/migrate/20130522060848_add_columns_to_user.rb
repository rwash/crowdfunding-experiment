class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string

    add_column :users, :creator_id, :integer

    add_column :users, :donor_id, :integer

  end
end
