Given /^I have an expense$/ do
  @expense = FactoryGirl.create(:expense)
end

When /^I add an expense$/ do
  visit expenses_path
  click_link "New"
  fill_in "Number",      :with => "42"
  fill_in "Reference",   :with => "A123"
  fill_in "Company",     :with => "Acme Inc."
  fill_in "Amount",      :with => "120.50"
  fill_in "Description", :with => "Phone bill January"
  click_button "Add expense"
end

When /^I list the expenses$/ do
  visit expenses_path
end

When /^I update the expense$/ do
  visit expenses_path
  click_link "edit"
  fill_in "Number",      :with => "50"
  fill_in "Reference",   :with => "B321"
  fill_in "Company",     :with => "Prime Corporation"
  fill_in "Amount",      :with => "100.25"
  fill_in "Description", :with => "Mobile bill February"
  click_button "Update"
end

Then /^the expense has been updated$/ do
  @expense.reload
  @expense.number.should      eql "50"
  @expense.reference.should   eql "B321"
  @expense.company.should     eql "Prime Corporation"
  @expense.amount.should      eql 100.25
  @expense.description.should eql "Mobile bill February"
end

Then /^I see the list of expenses$/ do
  within ".number" do
    page.should have_content(@expense.number)
  end
  within ".company" do
    page.should have_content(@expense.company)
  end
  within ".amount" do
    page.should have_content(@expense.amount)
  end
end
