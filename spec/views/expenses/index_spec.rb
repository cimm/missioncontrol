require "spec_helper"

describe "expenses/index" do
  let(:expense)  { mock_model(Expense) }
  let(:expenses) { [expense] }
  let(:number)   { mock("Number") }
  let(:company)  { mock("Company") }
  let(:amount)   { mock("Amount") }

  before :each do
    expense.stub(:number => number, :company => company, :amount => amount)
    assign :expenses, expenses
  end

  it "has a title" do
    render
    rendered.should have_content("Expenses")
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

  it "gets the amounts of the expenses" do
    expenses.each do |e|
      e.should_receive(:amount)
    end
    render
  end

  it "shows the amounts of the expenses" do
    render
    rendered.should have_tag(".amount", :text => amount)
  end
end
