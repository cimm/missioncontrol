%w{name street postcode city country vat_number}.each do |setting|
  Preference.create!(:setting => setting)
end
