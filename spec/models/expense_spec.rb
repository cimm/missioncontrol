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

end
