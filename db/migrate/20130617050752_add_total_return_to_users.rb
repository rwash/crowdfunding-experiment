class AddTotalReturnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_return, :integer
    add_column :users, :total_return_in_cents, :integer
  end
end
