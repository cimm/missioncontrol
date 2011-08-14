class AddUnits < ActiveRecord::Migration
  def up
    create_table :units do |t|
      t.date :executed_at, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :units
  end
end
