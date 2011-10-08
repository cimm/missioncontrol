class AddInvoices < ActiveRecord::Migration
  def up
    create_table :invoices do |t|
      t.integer :number, :null => false
      t.date    :payed_at
      t.date    :owed_at
      t.timestamps
    end
    add_index :invoices, :number, :unique => true
  end

  def down
    drop_table :invoices
  end
end
