require "spec_helper"

describe "invoices/index" do
  let(:invoice)  { mock_model(Invoice) }
  let(:invoices) { [invoice] }
  let(:number)   { "2011005" }
  let(:owed_at)  { Date.today }
  let(:payed_at) { Date.today }

  before :each do
    invoice.stub(:number => number, :owed_at => owed_at, :payed_at => payed_at)
    assign :invoices, invoices
  end

  it "has a title" do
    render
    rendered.should have_content("Invoices")
  end

  it "has a link to create a new invoice" do
    render
    rendered.should have_link("New")
  end

  it "gets the number of the invoices" do
    invoices.each do |i|
      i.should_receive(:number)
    end
    render
  end

  it "shows the number of the invoices" do
    render
    rendered.should have_tag(".number", :text => number)
  end

  it "gets the date the invoices are owed" do
    invoices.each do |i|
      i.should_receive(:owed_at).and_return(owed_at)
    end
    render
  end

  it "shows the date the invoices are owed" do
    render
    rendered.should have_tag(".owed_at", :text => owed_at.to_s)
  end

  it "gets the date the invoices are payed" do
    invoices.each do |i|
      i.should_receive(:payed_at).and_return(payed_at)
    end
    render
  end

  it "shows the date the invoices are payed" do
    render
    rendered.should have_tag(".payed_at", :text => payed_at.to_s)
  end

  it "shows an edit link for the invoices" do
    render
    rendered.should have_selector("a#edit_invoice_#{invoice.id}")
  end
end
