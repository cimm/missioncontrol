class AddExpenses < ActiveRecord::Migration
  def up
    create_table :expenses do |t|
      t.integer :number,    :null => false
      t.string  :reference
      t.string  :company,   :null => false
      t.decimal :amount,    :null => false, :precision => 8, :scale => 2
      t.boolean :debit,     :null => false, :default => true
      t.string  :description
      t.date    :booked_at, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :expenses
  end
end
