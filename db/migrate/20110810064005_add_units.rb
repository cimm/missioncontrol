class AddUnits < ActiveRecord::Migration
  def up
    create_table :units do |t|
      t.timestamps
    end
  end

  def down
    drop_table :units
  end
end
