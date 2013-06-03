class AddRoundCompleteToRounds < ActiveRecord::Migration
  def up
    add_column :rounds, :round_complete, :boolean, :default => false
    add_column :rounds, :summary_complete, :boolean, :default => false
  end
  
  def down
    remove_column :rounds, :round_complete
    remove_column :rounds, :summary_complete
  end
end
