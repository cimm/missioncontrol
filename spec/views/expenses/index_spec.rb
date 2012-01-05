require "spec_helper"

describe "expenses/index" do
  let(:expense)  { mock_model(Expense) }
  let(:expenses) { [expense] }

  before :each do
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
end
