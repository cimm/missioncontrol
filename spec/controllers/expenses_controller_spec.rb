require "spec_helper"

describe ExpensesController do
  let(:expense) { mock("Expense") }

  before :each do
    Expense.stub(:new => expense)
  end

  describe :index do
    let(:expenses) { mock("All expenses") }

    before :each do
      Expense.stub(:all => expenses)
    end

    it "gets all the expenses" do
      Expense.should_receive(:all)
      get :index
    end

    it "assigns all the expenses" do
      get :index
      assigns(:expenses).should eql expenses
    end

    it "renders the expenses page" do
      get :index
      response.should render_template(:index)
    end
  end
end
