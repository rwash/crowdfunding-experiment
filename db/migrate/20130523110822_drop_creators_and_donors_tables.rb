class DropCreatorsAndDonorsTables < ActiveRecord::Migration
  def up
    drop_table :creators
    drop_table :donors
  end

  def down
  end
end
