require "spec_helper"

describe "expenses/_form" do
  let(:expense)        { mock_model(Expense) }
  let(:partial_render) { render :partial => "expenses/form", :object => @form }

  before :each do
    expense.stub(:number => nil, :reference => nil, :company => nil, :description => nil, :amount => nil)
    form_for(expense) { |f| @form = f }
  end

  it "has a label for the number field" do
    partial_render
    rendered.should have_content("Number")
  end

  it "has a number text field for the expense" do
    partial_render
    rendered.should have_selector("#expense_number")
  end

  it "has a label for the reference field" do
    partial_render
    rendered.should have_content("Reference")
  end

  it "has a company text field for the reference" do
    partial_render
    rendered.should have_selector("#expense_reference")
  end

  it "has a label for the company field" do
    partial_render
    rendered.should have_content("Company")
  end

  it "has a company text field for the expense" do
    partial_render
    rendered.should have_selector("#expense_company")
  end

  it "has a label for the description field" do
    partial_render
    rendered.should have_content("Description")
  end

  it "has a description text field for the expense" do
    partial_render
    rendered.should have_selector("#expense_description")
  end

  it "has a label for the amount field" do
    partial_render
    rendered.should have_content("Amount")
  end

  it "has an amount text field for the expense" do
    partial_render
    rendered.should have_selector("#expense_amount")
  end

  it "has a label for the booked date fields" do
    partial_render
    rendered.should have_content("Booked at")
  end

  it "has booked date fields" do
    partial_render
    rendered.should have_selector("#expense_booked_at_1i")
    rendered.should have_selector("#expense_booked_at_2i")
    rendered.should have_selector("#expense_booked_at_3i")
  end
end
