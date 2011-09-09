class Project < ActiveRecord::Base
  belongs_to :client
  validates  :name,         :presence     => true
  validates  :client,       :presence     => true
  validates  :default_rate, :numericality => { :greater_than => 0 }, :allow_blank => true

  def client_nickname
    client.nickname
  end
end
