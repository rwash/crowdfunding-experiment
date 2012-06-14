class AddSessionToRound < ActiveRecord::Migration
  def change
  	add_column :rounds, :session_id, :integer
  end
end
