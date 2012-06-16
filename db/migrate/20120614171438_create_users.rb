class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :response_one
      t.string :response_two
      t.integer :payout
      t.string :token
      t.integer :session_id
      t.integer :times_viewed_instructions

      t.timestamps
    end
  end
end
