class AddProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string     :name,   :null => false
      t.references :client, :null => false
      t.integer    :default_rate
      t.timestamps
    end
    add_index :projects, :client_id
  end

  def down
    drop_table :projects
  end
end
