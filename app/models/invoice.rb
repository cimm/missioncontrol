class Invoice < ActiveRecord::Base
  has_many :units

  validates :number, :presence => true, :uniqueness => true

  def self.next_number
    previous_number = maximum(:number) || 0
    previous_number + 1
  end

  def selectable_units
    (units + Unit.not_invoiced).sort_by{|u| u.executed_at}
  end

  def has_invoiced_unit?(unit)
    units.include?(unit)
  end
end
