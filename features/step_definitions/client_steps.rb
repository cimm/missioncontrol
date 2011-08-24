When /^I add a client$/ do
  visit new_client_path
  fill_in "Nickname", :with => "Stradivarius"
  click_button "Add client"
end

Then /^the client has been added$/ do
  Client.count.should eql 1
end
