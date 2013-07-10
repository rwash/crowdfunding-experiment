class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|                    
      t.integer :user_id
      t.boolean :survey_complete, :default => false
      t.integer :q1
      t.string :q2
      t.boolean :q3
      t.string :q4
      t.boolean :q5
      t.boolean :q6
      t.string :q7_a
      t.string :q7_b
      t.boolean :q8
      t.string :q9
      t.string :q10
      t.string :q11
      t.string :q12_a
      t.string :q12_b
      t.string :q12_c
      t.string :q12_d

      t.timestamps
    end
  end
end
