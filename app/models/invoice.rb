class Invoice < ActiveRecord::Base
  has_many :units
  has_many :projects, :through => :units ,   :uniq => true
  has_many :clients,  :through => :projects, :uniq => true

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

  def overdue?
    !payed? && has_passed_its_owed_date?
  end

  def has_passed_its_owed_date?
    owed_at.present? && owed_at < Date.today
  end

  def payed?
    payed_at.present?
  end

  def cost_per_unit
    units.map(&:cost)
  end

  def total_amount_before_vat
    cost_per_unit.sum
  end

  def clients_nicknames
    clients.map(&:nickname)
  end
end
