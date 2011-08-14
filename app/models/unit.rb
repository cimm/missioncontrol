class Unit < ActiveRecord::Base
  validates :executed_at, :presence => true
end
