class AddUnitsToInvoices < ActiveRecord::Migration
  def change
    add_column :units, :invoice_id, :integer
    add_index  :units, :invoice_id
  end
end
