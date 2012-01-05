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
