# encoding: UTF-8
require "spec_helper"

describe "invoices/index" do
  let(:invoice)                 { mock_model(Invoice) }
  let(:invoices)                { [invoice] }
  let(:number)                  { mock("Invoice number") }
  let(:owed_at)                 { mock("Owed at date") }
  let(:payed_at)                { Date.today } # no mock due to bug in view matcher
  let(:overdue)                 { [true, false].sample }
  let(:total_amount_before_vat) { rand(500)+1000 }

  before :each do
    invoice.stub(:number => number, :owed_at => owed_at, :payed_at => payed_at, :overdue? => overdue, :total_amount_before_vat => total_amount_before_vat)
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
    rendered.should have_tag(".owed_at", :text => owed_at)
  end

  it "gets the date the invoices are payed" do
    invoices.each do |i|
      i.should_receive(:payed_at).and_return(payed_at)
    end
    render
  end

  it "shows the date the invoices are payed" do
    render
    rendered.should have_tag(".payed_at", :text => /#{payed_at}/) # regex needed due to bug in view matcher
  end

  it "checks if the invoice is overdue" do
    invoice.should_receive(:overdue?)
    render
  end

  context "is overdue" do
    before :each do
      invoice.stub(:overdue? => true)
    end

    it "shows an ovedue label" do
      render
      rendered.should have_tag(".important", :text => "Overdue")
    end
  end

  it "gets the total amounts for the invoices" do
    invoices.each do |i|
      i.should_receive(:total_amount_before_vat).and_return(total_amount_before_vat)
    end
    render
  end

  it "shows the total amount for the invoices" do
    render
    rendered.should have_tag(".total_amount_before_vat", :text => /€\s#{total_amount_before_vat}/)
  end

  it "shows an edit link for the invoices" do
    render
    rendered.should have_selector("a#edit_invoice_#{invoice.id}")
  end
end
