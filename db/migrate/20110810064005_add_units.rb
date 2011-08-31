class AddUnits < ActiveRecord::Migration
  def up
    create_table :units do |t|
      t.date       :executed_at, :null => false
      t.references :client
      t.timestamps
    end
    add_index :units, :client_id
  end

  def down
    drop_table :units
  end
end
