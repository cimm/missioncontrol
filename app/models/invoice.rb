class Invoice < ActiveRecord::Base
  VAT_PERCENTAGE_KEY = "vat_percentage"

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

  def total_amount_after_vat
    vat_percentage      = Preference.value_of(VAT_PERCENTAGE_KEY).to_i
    vat_on_total_amount = calculate_vat_on_total_amount(vat_percentage)
    calculate_total_amount_after_vat(total_amount_before_vat, vat_on_total_amount)
  end

  def calculate_vat_on_total_amount(vat_percentage)
    calculates_vat(total_amount_before_vat, vat_percentage)
  end

  def calculates_vat(amount, vat_percentage)
    amount * (vat_percentage * 0.01)
  end

  def calculate_total_amount_after_vat(total_amount_before_vat, vat_on_total_amount)
    total_amount_before_vat + vat_on_total_amount
  end

  def clients_nicknames
    clients.map(&:nickname)
  end
end
