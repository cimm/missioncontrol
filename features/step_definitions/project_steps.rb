Given /^I have a project$/ do
  @project = FactoryGirl.create(:project)
end

When /^I add a project$/ do
  visit projects_path
  click_link "New"
  fill_in "Name", :with => "Projectr"
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
  click_button "Update"
end

Then /^the project has been added$/ do
  Project.count.should eql 1
end

Then /^the project has been updated$/ do
  @project.reload
  @project.name.should   eql "Project Amadeus"
  @project.client.should eql @new_client
end

Then /^I see the list of projects$/ do
  within ".name" do
    page.should have_content(@project.name)
  end
end
