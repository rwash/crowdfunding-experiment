class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
