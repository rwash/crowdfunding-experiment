class ChangeGroupIdTypeInRounds < ActiveRecord::Migration
  def up
    change_column :rounds, :group_id, :integer
  end

  def down
    change_column :rounds, :group_id, :string
  end
end
