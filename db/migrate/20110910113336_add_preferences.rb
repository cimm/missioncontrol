class AddPreferences < ActiveRecord::Migration
  def up
    create_table :preferences do |t|
      t.string :setting, :null => false
      t.string :value
      t.timestamps
    end
    add_index :preferences, :setting
  end

  def down
    drop_table :preferences
  end
end
