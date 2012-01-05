class Expense < ActiveRecord::Base
  validates :number,  :presence => true
  validates :company, :presence => true
  validates :amount,  :numericality => { :greater_than => 0 }
end