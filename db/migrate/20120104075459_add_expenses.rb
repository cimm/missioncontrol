class AddExpenses < ActiveRecord::Migration
  def up
    create_table :expenses do |t|
      t.string  :number,   :null => false
      t.string  :reference
      t.string  :company,  :null => false
      t.integer :amount,   :null => false
      t.string  :description
      t.timestamps
    end
  end

  def down
    drop_table :expenses
  end
end