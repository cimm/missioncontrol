class Client < ActiveRecord::Base
  LANGUAGE_PAIRS = { "English" => "en", "Dutch" => "nl", "French" => "fr" }

  validates :nickname, :presence => true
end
