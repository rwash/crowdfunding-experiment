class RemoveUnusedColumns < ActiveRecord::Migration
  def up  
    remove_column :contributions, :time_contributed
    remove_column :contributions, :group_id
    remove_column :experiments, :finished_calc
    remove_column :users, :questions_payout
    remove_column :users, :payout
    remove_column :users, :question_1A
    remove_column :users, :question_1B
    remove_column :users, :question_2A
    remove_column :users, :question_2B
    remove_column :users, :question_2C
    remove_column :users, :question_2D  
    remove_column :projects, :admin_name
    remove_column :donor_preferences, :special_donor
  end

  def down
    add_column :contributions, :time_contributed, :datetime
    add_column :contributions, :group_id, :integer
    add_column :experiments, :finished_calc, :boolean
    add_column :users, :questions_payout, :integer
    add_column :users, :payout, :integer
    add_column :users, :question_1A, :string
    add_column :users, :question_1B, :string
    add_column :users, :question_2A, :integer
    add_column :users, :question_2B, :integer
    add_column :users, :question_2C, :integer
    add_column :users, :question_2D, :integer  
    add_column :projects, :admin_name, :string
    add_column :donor_preferences, :special_donor, :boolean                       
  end
end
