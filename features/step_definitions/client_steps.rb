Given /^I have a client$/ do
  @client = FactoryGirl.create(:client)
end

Given /^I have a client with a VAT number$/ do
  @client = FactoryGirl.create(:client_with_vat_number)
end

When /^I add a client$/ do
  visit clients_path
  click_link "New"
  fill_in "Nickname",   :with => "Acme"
  fill_in "Name",       :with => "Acme Corporation"
  fill_in "Street",     :with => "Bondgenotenlaan 1"
  fill_in "Postcode",   :with => "3000"
  fill_in "City",       :with => "Leuven"
  fill_in "Country",    :with => "Belgium"
  select  "French",    :from => "Language"
  fill_in "VAT number", :with => "0999999999"
  click_button "Add client"
end

When /^I try to add an empty client$/ do
  visit new_client_path
  click_button "Add client"
end

When /^I list the clients$/ do
  visit clients_path
end

When /^I edit the client$/ do
  visit edit_client_path(@client)
end

When /^I update the client$/ do
  visit clients_path
  click_link "edit_client_#{@client.id}"
  fill_in "Nickname",   :with => "Prime"
  fill_in "Name",       :with => "Prime Corporation"
  fill_in "Street",     :with => "Keyworth Street 1"
  fill_in "Postcode",   :with => "SE10AA"
  fill_in "City",       :with => "London"
  fill_in "Country",    :with => "United Kingdom"
  select  "English",    :from => "Language"
  fill_in "VAT number", :with => "999 9999 73"
  click_button "Update"
end

Then /^the client has been updated$/ do
  @client.reload
  @client.nickname.should    eql "Prime"
  @client.name.should        eql "Prime Corporation"
  @client.street.should      eql "Keyworth Street 1"
  @client.postcode.should    eql "SE10AA"
  @client.city.should        eql "London"
  @client.country.should     eql "United Kingdom"
  @client.language.should    eql "en"
  @client.vat_number.should  eql "999 9999 73"
end

Then /^I see the list of clients$/ do
  within ".nickname" do
    page.should have_content(@client.nickname)
  end
end

Then /^the VAT number is validated$/ do
  page.should have_content("NOT VALID")
end
