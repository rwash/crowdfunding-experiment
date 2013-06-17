class ChangeNumberInRounds < ActiveRecord::Migration
  def up
    change_column :rounds, :number, :integer, :default => nil
  end

  def down
    change_column :rounds, :number, :integer, :default => 1
  end
end
