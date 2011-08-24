class AddClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string :nickname, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :clients
  end
end
