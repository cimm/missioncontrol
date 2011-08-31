class Unit < ActiveRecord::Base
  belongs_to :client
  validates :executed_at, :presence => true
  validates :client,      :presence => true

  def client_nickname
    client.nickname
  end
end
