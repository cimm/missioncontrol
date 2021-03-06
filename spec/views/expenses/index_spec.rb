require "spec_helper"

describe "expenses/index" do
  let(:expense)       { mock_model(Expense) }
  let(:expenses)      { [expense] }
  let(:number)        { mock("Number") }
  let(:company)       { mock("Company") }
  let(:signed_amount) { mock("Signed amount") }

  before :each do
    expense.stub(:number => number, :company => company, :signed_amount => signed_amount)
    assign :expenses, expenses
  end

  it "has a title" do
    render
    rendered.should have_content("Expenses")
  end

  it "has a link to filter on fiscal quarter" do
    render
    rendered.should have_link("Q1")
    rendered.should have_link("Q2")
    rendered.should have_link("Q3")
    rendered.should have_link("Q4")
  end

  it "has a link to remove the filter" do
    render
    rendered.should have_link("All")
  end

  it "has a link to create a new expense" do
    render
    rendered.should have_link("New")
  end

  it "gets the numbers of the expenses" do
    expenses.each do |e|
      e.should_receive(:number)
    end
    render
  end

  it "shows the numbers of the expenses" do
    render
    rendered.should have_tag(".number", :text => number)
  end

  it "gets the companies of the expenses" do
    expenses.each do |e|
      e.should_receive(:company)
    end
    render
  end

  it "shows the companies of the expenses" do
    render
    rendered.should have_tag(".company", :text => company)
  end

  it "gets the signed amounts of the expenses" do
    expenses.each do |e|
      e.should_receive(:signed_amount)
    end
    render
  end

  it "shows the signed amounts of the expenses" do
    render
    rendered.should have_tag(".signed-amount", :text => signed_amount)
  end

  it "shows an edit link for the expenses" do
    render
    rendered.should have_selector("a#edit_expense_#{expense.id}")
  end
end
