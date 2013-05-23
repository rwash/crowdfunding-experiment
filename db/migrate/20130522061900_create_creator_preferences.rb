class CreateCreatorPreferences < ActiveRecord::Migration
  def change
    create_table :creator_preferences do |t|
      t.integer :creator_id
      t.integer :round_id

      t.timestamps
    end
  end
end
