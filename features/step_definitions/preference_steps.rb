Given /^I have a preference$/ do
  @preference = FactoryGirl.create(:preference, :value => "Some value")
end

When /^I list the preferences$/ do
  visit preferences_path
end

When /^I update the preference$/ do
  visit preferences_path
  click_link "edit"
  fill_in @preference.setting.humanize, :with => "Another value"
  click_button "Update"
end

Then /^the preference has been updated$/ do
  @preference.reload
  @preference.value.should eql "Another value"
end

Then /^I see the list of preferences$/ do
  within ".setting" do
    page.should have_content(@preference.setting.humanize)
  end
  within ".value" do
    page.should have_content(@preference.value)
  end
end
