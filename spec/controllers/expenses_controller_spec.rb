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

  describe "new" do
    it "creates a new expense" do
      Expense.should_receive(:new)
      get :new
    end

    it "assigns the expense" do
      get :new
      assigns(:expense).should eql expense
    end

    it "renders the new expense page" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "create" do
    let(:params) { {} }

    before :each do
      expense.stub(:save)
    end

    it "builds a new expense" do
      Expense.should_receive(:new).with(params)
      post :create, :expense => params
    end

    it "assigns the expense" do
      post :create, :expense => params
      assigns(:expense).should eql expense
    end

    it "tries to persist the expense" do
      expense.should_receive(:save)
      post :create, :expense => params
    end

    context "is valid" do
      before :each do
        expense.stub(:save => true)
      end

      it "assigns a flash message" do
        post :create, :expense => params
        flash[:notice].should_not be_nil
      end

      it "redirects to the expenses index page" do
        post :create, :expense => params
        response.should redirect_to(:action => "index")
      end
    end

    context "is not valid" do
      before :each do
        expense.stub(:save => false)
      end

      it "assigns a non-sticky error flash message" do
        post :create, :expense => params
        flash.now[:error].should_not be_nil
        # TODO Isn't testing the "stickyness" at the moment
      end

      it "renders the new page" do
        post :create, :expense => params
        response.should render_template(:new)
      end
    end
  end
end
