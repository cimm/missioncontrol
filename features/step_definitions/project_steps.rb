Given /^I have a project$/ do
  @project = FactoryGirl.create(:project)
end

When /^I add a project$/ do
  visit projects_path
  click_link "New"
  fill_in "Name",         :with => "Stradivarius"
  fill_in "Default rate", :with => "400"
  click_button "Add project"
end

When /^I try to add a project with missing details$/ do
  visit projects_path
  click_link "New"
  click_button "Add project"
end

When /^I list the projects$/ do
  visit projects_path
end

When /^I update the project$/ do
  @new_client = FactoryGirl.create(:client)
  visit projects_path
  click_link "edit"
  fill_in "Name",              :with => "Project Amadeus"
  select @new_client.nickname, :from => "Client"
  fill_in "Default rate",      :with => "450"
  click_button "Update"
end

Then /^the project has been updated$/ do
  @project.reload
  @project.name.should         eql "Project Amadeus"
  @project.default_rate.should eql 450
  @project.client.should       eql @new_client
end

Then /^I see the list of projects$/ do
  within ".name" do
    page.should have_content(@project.name)
  end
  within ".nickname" do
    page.should have_content(@project.client_nickname)
  end
  within ".default_rate" do
    page.should have_content(@project.default_rate)
  end
end
