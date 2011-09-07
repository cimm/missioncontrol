class Unit < ActiveRecord::Base
  belongs_to :project
  validates  :executed_at, :presence => true
  validates  :project,     :presence => true

  def project_name
    project.name
  end
end
