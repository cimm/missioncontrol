class Project < ActiveRecord::Base
  belongs_to :client
  validates :name,   :presence => true
  validates :client, :presence => true
end
