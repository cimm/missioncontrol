class Unit < ActiveRecord::Base
  belongs_to :project
  validates  :executed_at, :presence => true
  validates  :hours_spent, :presence => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 24 }
  validates  :project,     :presence => true

  def project_name
    project.name
  end
end
