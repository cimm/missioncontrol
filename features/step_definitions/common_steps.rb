Given /^I am on the homepage$/ do
  visit root_path
end

When /^I go to the (.*) page$/ do |page|
  within ".nav" do
    click_link page.humanize
  end
end

Then /^the (.*) (has(?: not)?) been added$/ do |klass, added|
  elements_in_database = (added ? 1 : 0)
  klass.capitalize.constantize.count.should eql elements_in_database
end

Then /^I am on the (.*) page$/ do |p|
  within "h1" do
    page.should have_content(p.humanize)
  end
end
