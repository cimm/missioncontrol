class Expense < ActiveRecord::Base
  validates :number,    :presence => true
  validates :company,   :presence => true
  validates :amount,    :numericality => { :greater_than => 0 }
  validates :booked_at, :presence => true

  def self.next_number
    previous_number = maximum(:number) || 0
    previous_number + 1
  end
end
