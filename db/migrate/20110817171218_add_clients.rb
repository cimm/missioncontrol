class AddClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string :nickname, :null => false
      t.string :name
      t.timestamps
    end
    add_index :clients, :nickname
  end

  def down
    drop_table :clients
  end
end
