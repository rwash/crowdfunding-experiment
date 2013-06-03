class AddColumnsToRounds < ActiveRecord::Migration
  def up
    rename_column :rounds, :started, :part_a_started
    rename_column :rounds, :finished, :part_a_finished
    add_column :rounds, :part_b_started, :boolean, :default => false
    add_column :rounds, :part_b_finished, :boolean, :default => false
  end
  
  def down
    rename_column :rounds, :part_a_started, :started
    rename_column :rounds, :part_a_finished, :finished
    remove_column :rounds, :part_b_started
    remove_column :rounds, :part_b_finished
  end
end
