Given /^I added a unit$/ do
  @unit = FactoryGirl.create(:unit)
end

When /^I add a unit$/ do
  visit units_path
  click_button "Add unit"
end

When /^I list the units$/ do
  visit units_path
end

Then /^the unit has been added$/ do
  Unit.count.should eql 1
end

Then /^I see date the unit was executed$/ do
  page.should have_content(@unit.executed_at)
end
