World(ActionView::Helpers::DateHelper, TimeHelper)

Given /^I have a unit$/ do
  @unit = FactoryGirl.create(:unit)
end

When /^I add a unit$/ do
  visit units_path
  click_link "New"
  fill_in "unit_hours_spent", :with => "4"
  click_button "Add unit"
end

When /^I try to add a unit with missing details$/ do
  visit units_path
  click_link "New"
  click_button "Add unit"
end

When /^I list the units$/ do
  visit units_path
end

When /^I update the unit$/ do
  @new_project = FactoryGirl.create(:project)
  @hours_spent = 8
  visit units_path
  click_link "edit"
  last_year = Date.today - 1.year
  select last_year.year.to_s,      :from => "unit_executed_at_1i"
  select last_year.strftime('%B'), :from => "unit_executed_at_2i"
  select last_year.day.to_s,       :from => "unit_executed_at_3i"
  select @new_project.name,        :from => "Project"
  fill_in "unit_hours_spent",      :with => @hours_spent
  click_button "Update"
end

Then /^the unit has been updated$/ do
  last_year = Date.today - 1.year
  @unit.reload
  @unit.executed_at.should eql last_year
  @unit.project.should     eql @new_project
  @unit.hours_spent.should eql @hours_spent
end

Then /^I see the list of units$/ do
  within ".executed_at" do
    page.should have_content(@unit.executed_at)
  end
  within ".hours_spent" do
    formatted_hours_spent = formatted_hours(@unit.hours_spent)
    page.should have_content(formatted_hours_spent)
  end
end

Then /^I am warned yesterday's unit is missing$/ do
  within ".notice" do
    page.should have_content("No unit found for yesterday")
  end
end
