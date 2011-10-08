class Unit < ActiveRecord::Base
  belongs_to :project
  belongs_to :invoice

  validates  :executed_at, :presence => true
  validates  :hours_spent, :presence => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 24 }
  validates  :project,     :presence => true

  def self.not_invoiced
    Unit.all.reject{|u| u.invoiced?}
  end

  def project_name
    project.name
  end

  def invoiced?
    invoice.present?
  end
end
