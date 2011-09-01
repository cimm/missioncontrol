class AddClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string :nickname, :null => false
      t.string :name
      t.string :street
      t.string :postcode
      t.string :city
      t.string :country
      t.string :vat_number
      t.timestamps
    end
    add_index :clients, :nickname
  end

  def down
    drop_table :clients
  end
end
