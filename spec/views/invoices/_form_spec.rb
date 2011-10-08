require "spec_helper"

describe "invoices/_form" do
  let(:invoice)          { mock_model(Invoice) }
  let(:selectable_units) { [mock_model(Unit)] }
  let(:executed_at)      { mock("Unit executed at") }
  let(:hours_spent)      { mock("Hours spent on unit") }
  let(:partial_render)   { render :partial => "invoices/form", :object => @form }

  before :each do
    invoice.stub(:number => nil, :owed_at => nil, :payed_at => nil, :has_invoiced_unit? => nil)
    selectable_units.each do  |u|
      u.stub(:executed_at => executed_at, :hours_spent => hours_spent)
    end
    form_for(invoice) { |f| @form = f }
    assign :selectable_units, selectable_units
    assign :invoice,          invoice
  end

  it "has a label for the number" do
    partial_render
    rendered.should have_content("Number")
  end

  it "has a number field" do
    partial_render
    rendered.should have_selector("#invoice_number")
  end

  it "has a label for the owed date fields" do
    partial_render
    rendered.should have_content("Owed at")
  end

  it "has owed date fields" do
    partial_render
    rendered.should have_selector("#invoice_owed_at_1i")
    rendered.should have_selector("#invoice_owed_at_2i")
    rendered.should have_selector("#invoice_owed_at_3i")
  end

  it "has a label for the payed date fields" do
    partial_render
    rendered.should have_content("Payed at")
  end

  it "has payed date fields" do
    partial_render
    rendered.should have_selector("#invoice_payed_at_1i")
    rendered.should have_selector("#invoice_payed_at_2i")
    rendered.should have_selector("#invoice_payed_at_3i")
  end

  context "new" do
    it "does not propose a date in the payed date fields" do
      partial_render
      rendered.should have_tag("#invoice_payed_at_1i") do
        with_tag "option", :with => {:value => nil}
      end
      rendered.should have_tag("#invoice_payed_at_2i") do
        with_tag "option", :with => {:value => nil}
      end
      rendered.should have_tag("#invoice_payed_at_3i") do
        with_tag "option", :with => {:value => nil}
      end
    end
  end

  it "has a label for each selectable unit" do
    partial_render
    rendered.should have_content("Units")
  end

  it "has a hidden field for each selectable unit" do
    partial_render
    selectable_units.each do
      rendered.should have_tag("input", :with => {:name => "invoice[unit_ids][]", :type => "hidden"})
    end
  end

  it "checks if the selectable unit is already linked to the invoice" do
    selectable_units.each do |u|
      invoice.should_receive(:has_invoiced_unit?).with(u)
    end
    partial_render
  end

  it "gets the id for each selectable unit" do
    selectable_units.each do |u|
      u.should_receive(:id).twice
    end
    partial_render
  end

  it "has a check box for each selectable unit" do
    partial_render
    selectable_units.each do |u|
      rendered.should have_selector("#invoice_unit_ids_#{u.id}")
    end
  end

  it "gets the date these units where executed" do
    selectable_units.each do |u|
      u.should_receive(:executed_at)
    end
    partial_render
  end

  it "shows the date these units where executed" do
    partial_render
    selectable_units.each do |u|
      rendered.should have_content(u.executed_at)
    end
  end

  it "gets the hours spent for these units" do
    selectable_units.each do |u|
      u.should_receive(:hours_spent)
    end
    partial_render
  end

  it "shows the hours spent for these units" do
    partial_render
    selectable_units.each do |u|
      rendered.should have_content(u.hours_spent)
    end
  end
end
