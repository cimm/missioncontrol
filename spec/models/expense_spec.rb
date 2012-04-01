require "spec_helper"

describe Expense do
  WITHIN_DATE_RANGE_SQL = "DATE(booked_at) >= ? AND DATE(booked_at) <= ?"

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

  it "accepts a decimal amount" do
    expense.amount = 400.50
    expense.amount.should eql 400.50
  end

  it "isn't valid with a negative amount" do
    expense.amount = -500
    expense.should_not be_valid
  end

  it "has a debit flag" do
    expense.should respond_to :debit?
    expense.should respond_to :debit=
  end

  it "is debit by default" do
    expense = Expense.new
    expense.should be_debit
  end

  it "has a description" do
    expense.should respond_to :description
    expense.should respond_to :description=
  end

  it "has a booked date" do
    expense.should respond_to :booked_at
    expense.should respond_to :booked_at=
  end

  it "isn't valid without a booked date" do
    expense.booked_at = nil
    expense.should_not be_valid
  end

  describe "self.next_number" do
    let(:previous_expense_number) { mock("Previous expense number") }
    let(:next_expense_number)     { mock("Next expense number") }

    before :each do
      Expense.stub(:maximum => previous_expense_number)
      previous_expense_number.stub(:+ => next_expense_number)
    end

    it "gets the highest expense number" do
      Expense.should_receive(:maximum).with(:number)
      Expense.next_number
    end

    context "there are other expenses" do
      it "calculates the next number" do
        previous_expense_number.should_receive(:+).with(1)
        Expense.next_number
      end

      it "returns the next number" do
        Expense.next_number.should eql next_expense_number
      end
    end

    context "there are no other expenses" do
      let(:previous_expense_number) do
        allow_message_expectations_on_nil
        nil
      end

      it "returns 1 as the next number" do
        Invoice.next_number.should eql 1
      end
    end
  end

  describe "self.within_date_range" do
    let(:start_date)    { mock("Start date") }
    let(:end_date)      { mock("End date") }
    let(:sql_statement) { [WITHIN_DATE_RANGE_SQL, start_date, end_date] }
    let(:expenses)      { [mock("Expense")] }

    before :each do
      Expense.stub(:where => expenses)
    end

    it "builds the SQL statement" do
      Expense.should_receive(:where).with(sql_statement)
      Expense.within_date_range(start_date, end_date)
    end

    it "returns the expenses" do
      Expense.within_date_range(start_date, end_date).should eql expenses
    end
  end

  describe :signed_amount do
    let(:amount) { 500 }

    before :each do
      expense.stub(:amount => amount, :debit? => true)
    end

    it "gets the amount" do
      expense.should_receive(:amount)
      expense.signed_amount
    end

    it "checks if it's a debit expense" do
      expense.should_receive(:debit?)
      expense.signed_amount
    end

    context "when it's a debit expense" do
      before :each do
        expense.stub(:debit? => true)
      end

      it "returns the amount" do
        expense.signed_amount.should eql 500
      end
    end

    context "when it's a credit expense" do
      before :each do
        expense.stub(:debit? => false)
      end

      it "returns the signed amount" do
        expense.signed_amount.should eql -500
      end
    end
  end
end
