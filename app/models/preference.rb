class Preference < ActiveRecord::Base
  validates :setting, :presence => true
end
