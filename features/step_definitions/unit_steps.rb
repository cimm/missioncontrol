Given /^I have a unit$/ do
  @unit = FactoryGirl.create(:unit)
end

When /^I add a unit$/ do
  visit units_path
  click_button "Add unit"
end

When /^I list the units$/ do
  visit units_path
end

When /^I update the unit$/ do
  @new_project = FactoryGirl.create(:project)
  visit units_path
  click_link "edit"
  last_year = Date.today - 1.year
  select last_year.year.to_s,      :from => "unit_executed_at_1i"
  select last_year.strftime('%B'), :from => "unit_executed_at_2i"
  select last_year.day.to_s,       :from => "unit_executed_at_3i"
  select @new_project.name,        :from => "Project"
  click_button "Update"
end

Then /^the unit has been added$/ do
  Unit.count.should eql 1
end

Then /^the unit has been updated$/ do
  last_year = Date.today - 1.year
  @unit.reload
  @unit.executed_at.should eql last_year
  @unit.project.should     eql @new_project
end

Then /^I see the list of units$/ do
  within ".executed_at" do
    page.should have_content(@unit.executed_at)
  end
end
