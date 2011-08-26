class Client < ActiveRecord::Base
  validates :nickname, :presence => true
end
