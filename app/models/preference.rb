class Preference < ActiveRecord::Base
  validates :setting, :presence => true

  def self.value_of(setting)
    if preference = find_by_setting(setting)
      preference.value
    else
      "0"
    end
  end
end
