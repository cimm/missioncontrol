Given /^I added a client$/ do
  @client = FactoryGirl.create(:client)
end

When /^I add a client$/ do
  visit new_client_path
  fill_in "Nickname", :with => "Acme"
  fill_in "Name",     :with => "Acme Corporation"
  click_button "Add client"
end

When /^I list the clients$/ do
  visit clients_path
end

When /^I update the client$/ do
  visit clients_path
  click_link "edit"
  fill_in "Nickname", :with => "Prime"
  fill_in "Name",     :with => "Prime Corporation"
  click_button "Update"
end

Then /^the client has been added$/ do
  Client.count.should eql 1
end

Then /^the client has been updated$/ do
  @client.reload
  @client.nickname.should eql "Prime"
  @client.name.should     eql "Prime Corporation"
end

Then /^I see the list of clients$/ do
  within ".nickname" do
    page.should have_content(@client.nickname)
  end
end
