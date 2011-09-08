class AddUnits < ActiveRecord::Migration
  def up
    create_table :units do |t|
      t.date       :executed_at, :null => false
      t.decimal    :hours_spent, :null => false, :precision => 4, :scale => 2
      t.references :project,     :null => false
      t.timestamps
    end
    add_index :units, :project_id
  end

  def down
    drop_table :units
  end
end
