class DropPreferences < ActiveRecord::Migration
  def up
    drop_table :preferences
  end
end
