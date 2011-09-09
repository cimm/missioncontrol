Given /^I am on the homepage$/ do
  visit root_path
end

When /^I go to the (.*) page$/ do |page|
  within ".topbar" do
    click_link page.humanize
  end
end

Then /^I am on the (.*) page$/ do |p|
  within "h1" do
    page.should have_content(p.humanize)
  end
end
