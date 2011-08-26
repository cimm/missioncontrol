Given /^I added a client$/ do
  @client = FactoryGirl.create(:client)
end

When /^I add a client$/ do
  visit new_client_path
  fill_in "Nickname", :with => "Stradivarius"
  click_button "Add client"
end

When /^I list the clients$/ do
  visit clients_path
end

When /^I edit the client's nickname$/ do
  visit clients_path
  click_link "edit"
  fill_in "Nickname", :with => "Antonio"
  click_button "Update"
end

Then /^the client has been added$/ do
  Client.count.should eql 1
end

Then /^I see the nickname of the client$/ do
  page.should have_content(@client.nickname)
end

Then /^I see the client's new nickname$/ do
  page.should have_content("Antonio")
  page.should_not have_content("Stradivarius")
end
