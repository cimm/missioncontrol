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

When /^I edit the unit's date$/ do
  visit units_path
  click_link "edit"
  last_year = Date.today - 1.year
  select last_year.year.to_s,      :from => "unit_executed_at_1i"
  select last_year.strftime('%B'), :from => "unit_executed_at_2i"
  select last_year.day.to_s,       :from => "unit_executed_at_3i"
  click_button "Update"
end

Then /^the unit has been added$/ do
  Unit.count.should eql 1
end

Then /^I see date the unit was executed$/ do
  page.should have_content(@unit.executed_at)
end

Then /^I see the unit's new date$/ do
  last_year = Date.today - 1.year
  page.should have_content(last_year)
end
