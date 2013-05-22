class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
