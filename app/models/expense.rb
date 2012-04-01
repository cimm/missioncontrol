class Expense < ActiveRecord::Base
  WITHIN_DATE_RANGE_SQL = "DATE(booked_at) >= ? AND DATE(booked_at) <= ?"

  validates :number,    :presence => true
  validates :company,   :presence => true
  validates :amount,    :numericality => { :greater_than => 0 }
  validates :booked_at, :presence => true

  def self.next_number
    previous_number = maximum(:number) || 0
    previous_number + 1
  end

  def self.within_date_range(start_date, end_date)
    where([WITHIN_DATE_RANGE_SQL, start_date, end_date])
  end

  def signed_amount
    debit? ? amount : amount * -1
  end
end
