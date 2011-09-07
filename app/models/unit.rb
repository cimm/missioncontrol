class Unit < ActiveRecord::Base
  belongs_to :client
  validates :executed_at, :presence => true
end
