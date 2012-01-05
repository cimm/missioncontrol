require "spec_helper"

describe Expense do
  let(:expense) { FactoryGirl.build(:expense) }

  it "has a creation date" do
    expense.should respond_to :created_at
    expense.should respond_to :created_at=
  end

  it "has an updated date" do
    expense.should respond_to :updated_at
    expense.should respond_to :updated_at=
  end

  it "has a number" do
    expense.should respond_to :number
    expense.should respond_to :number=
  end

  it "isn't valid without a number" do
    expense.number = nil
    expense.should_not be_valid
  end

  it "has a reference" do
    expense.should respond_to :reference
    expense.should respond_to :reference=
  end

  it "has a company" do
    expense.should respond_to :company
    expense.should respond_to :company=
  end

  it "isn't valid without a company" do
    expense.company = nil
    expense.should_not be_valid
  end

  it "has an amount" do
    expense.should respond_to :reference
    expense.should respond_to :reference=
  end

  it "isn't valid without an amount" do
    expense.amount = nil
    expense.should_not be_valid
  end

  it "isn't valid with a negative amount" do
    expense.amount = -500
    expense.should_not be_valid
  end

  it "has a description" do
    expense.should respond_to :description
    expense.should respond_to :description=
  end
end
