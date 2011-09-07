class AddUnits < ActiveRecord::Migration
  def up
    create_table :units do |t|
      t.date       :executed_at, :null => false
      t.references :project,     :null => false
      t.timestamps
    end
    add_index :units, :project_id
  end

  def down
    drop_table :units
  end
end
