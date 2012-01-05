When /^I add an expense$/ do
  visit expenses_path
  click_link "New"
  fill_in "Number",      :with => "42"
  fill_in "Reference",   :with => "A123"
  fill_in "Company",     :with => "Acme Inc."
  fill_in "Amount",      :with => "120.50"
  fill_in "Description", :with => "Phone bill January"
  click_button "Add expense"
end
