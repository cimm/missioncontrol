class Unit < ActiveRecord::Base
  belongs_to :project
  belongs_to :invoice

  validates  :executed_at, :presence => true
  validates  :hours_spent, :presence => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 24 }
  validates  :project,     :presence => true

  def self.not_invoiced
    Unit.all.reject{|u| u.invoiced?}
  end

  def self.has_units_for_yesterday?
    yesterday        = Date.today - 1
    yesterdays_units = Unit.where(:executed_at => yesterday)
    yesterdays_units.any? ? true : false
  end

  def project_name
    project.name
  end

  def invoiced?
    invoice.present?
  end

  def cost
    project.default_rate || 0
  end
end
