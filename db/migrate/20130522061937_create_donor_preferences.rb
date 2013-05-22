class CreateDonorPreferences < ActiveRecord::Migration
  def change
    create_table :donor_preferences do |t|
      t.integer :donor_id
      t.integer :round_id

      t.timestamps
    end
  end
end
