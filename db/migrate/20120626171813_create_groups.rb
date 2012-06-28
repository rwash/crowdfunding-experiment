class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :experiment_id
      t.string :name

      t.timestamps
    end
  end
end
