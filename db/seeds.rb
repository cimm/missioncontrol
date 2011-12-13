%w{name street postcode city country vat_number vat_percentage}.each do |setting|
  Preference.create!(:setting => setting)
end
