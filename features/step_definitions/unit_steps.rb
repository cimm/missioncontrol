When /^I add a unit$/ do
  visit units_path
  click_button "Add unit"
end

Then /^the unit has been added$/ do
  Unit.count.should eql 1
end
