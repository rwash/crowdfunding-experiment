class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.boolean :condition

      t.timestamps
    end
  end
end
