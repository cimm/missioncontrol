class AddProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string     :name,         :null => false
      t.references :client,       :null => false
      t.decimal    :default_rate, :precision => 8, :scale => 2
      t.timestamps
    end
    add_index :projects, :client_id
  end

  def down
    drop_table :projects
  end
end
