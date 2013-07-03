class RenameTotalReturnInCentsInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :total_return_in_cents, :total_return_in_dollars
  end

  def down
    rename_column :users, :total_return_in_dollars, :total_return_in_cents
  end
end
