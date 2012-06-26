class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.integer :payout
      t.integer :questions_payout
      t.string :token
      t.integer :experiment_id
      t.integer :times_viewed_instructions
      t.string  :persistence_token,   :null => false # for auth logic
      t.string :question_1A
      t.string :question_1B
      t.integer :question_2A
      t.integer :question_2B
      t.integer :question_2C
      t.integer :question_2D
      
      t.timestamps
    end
  end
end
