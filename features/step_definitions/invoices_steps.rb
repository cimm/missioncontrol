Given /^I have an invoice$/ do
  @invoice = FactoryGirl.create(:invoice)
end

Given /^I have a payed invoice$/ do
  @invoice = FactoryGirl.create(:payed_invoice)
end

Given /^I have an overdue invoice$/ do
  @invoice = FactoryGirl.create(:overdue_invoice)
end

When /^I add an invoice$/ do
  visit invoices_path
  click_link "New"
  click_button "Add invoice"
end

When /^I try to add an invoice with missing details$/ do
  visit invoices_path
  click_link "New"
  fill_in "Number", :with => ""
  click_button "Add invoice"
end

When /^I list the invoices$/ do
  visit invoices_path
end

When /^I update the invoice$/ do
  visit invoices_path
  click_link "edit_invoice_#{@invoice.id}"
  fill_in "Number",                    :with => "2011999"
  last_year = Date.today - 1.year
  select last_year.year.to_s,          :from => "invoice_owed_at_1i"
  select last_year.strftime('%B'),     :from => "invoice_owed_at_2i"
  select last_year.day.to_s,           :from => "invoice_owed_at_3i"
  two_years_ago = Date.today - 2.year
  select two_years_ago.year.to_s,      :from => "invoice_payed_at_1i"
  select two_years_ago.strftime('%B'), :from => "invoice_payed_at_2i"
  select two_years_ago.day.to_s,       :from => "invoice_payed_at_3i"
  check "invoice_unit_ids_1"
  click_button "Update"
end

Then /^the invoice has been updated$/ do
  last_year     = Date.today - 1.year
  two_years_ago = Date.today - 2.year
  @invoice.reload
  @invoice.number.should   eql 2011999
  @invoice.owed_at.should  eql last_year
  @invoice.payed_at.should eql two_years_ago
  @invoice.units.should    eql [@unit]
end

Then /^I see the list of invoices$/ do
  within ".number" do
    page.should have_content(@invoice.number)
  end
  within ".clients_nicknames" do
    page.should have_content(@invoice.clients_nicknames.join(", "))
  end
  within ".owed_at" do
    page.should have_content(@invoice.owed_at)
  end
  within ".payed_at" do
    page.should have_content(@invoice.payed_at)
  end
  within ".total_amount_before_vat" do
    page.should have_content(@invoice.total_amount_before_vat)
  end
  within ".total_amount_after_vat" do
    page.should have_content(@invoice.total_amount_after_vat)
  end
end

Then /^I see the invoice is overdue$/ do
  within ".payed_at" do
    page.should have_content("Overdue")
  end
end
