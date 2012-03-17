require "spec_helper"

DATE_FORMAT = "%Y-%m-%d"

describe ExpensesController do
  let(:expense) { mock("Expense") }

  before :each do
    Expense.stub(:new => expense)
  end

  describe :index do
    let(:expenses) { mock("Expenses") }

    context "when the data range filter is applied" do
      let(:date_range_param) { "Date range param" }
      let(:params)           { {:date_range => date_range_param } }
      let(:date_range)       { mock("Date range") }
      let(:start_date)       { mock("Start date") }
      let(:end_date)         { mock("End date") }

      before :each do
        Expense.stub(:within_date_range => expenses)
        DateRange.stub(:new => date_range)
        date_range.stub(:start_date => start_date, :end_date => end_date)
      end

      it "builds a new date range" do
        DateRange.should_receive(:new).with(date_range_param)
        get :index, params
      end

      it "gets the start date from the date range" do
        date_range.should_receive(:start_date)
        get :index, params
      end

      it "gets the end date from the date range" do
        date_range.should_receive(:end_date)
        get :index, params
      end

      it "gets only the expenses within the data range" do
        Expense.should_receive(:within_date_range).with(start_date, end_date)
        get :index, params
      end

      it "assigns the expenses within the date range" do
        get :index, params
        assigns(:expenses).should eql expenses
      end

      it "does not get all the expenses" do
        Expense.should_not_receive(:all)
        get :index, params
      end
    end

    context "when no filter is applied" do
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
    end

    it "renders the expenses page" do
      get :index
      response.should render_template(:index)
    end
  end

  describe :new do
    let(:next_number) { mock("Next number") }

    before :each do
      Expense.stub(:next_number => next_number)
      expense.stub(:number= => nil)
    end

    it "creates a new expense" do
      Expense.should_receive(:new)
      get :new
    end

    it "assigns the expense" do
      get :new
      assigns(:expense).should eql expense
    end

    it "gets the next number" do
      Expense.should_receive(:next_number)
      get :new
    end

    it "adds the next number to the expense" do
      expense.should_receive(:number=).with(next_number)
      get :new
    end

    it "renders the new expense page" do
      get :new
      response.should render_template(:new)
    end
  end

  describe :create do
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

  describe :edit do
    let(:expense_id) { "Id for the edited expense"}

    before :each do
      Expense.stub(:find => expense)
    end

    it "gets the expense to edit" do
      Expense.should_receive(:find).with(expense_id)
      get :edit, :id => expense_id
    end

    it "assigns the expense" do
      get :edit, :id => expense_id
      assigns(:expense).should eql expense
    end

    it "renders the edit page" do
      get :edit, :id => expense_id
      response.should render_template(:edit)
    end
  end

  describe :update do
    let(:expense_id) { "Id for the updated expense" }
    let(:params)     { {} }

    before :each do
      Expense.stub(:find => expense)
      expense.stub(:update_attributes)
    end

    it "gets the expense to update" do
      Expense.should_receive(:find).with(expense_id)
      put :update, :id => expense_id, :expense => params
    end

    it "updates and persists the expense" do
      expense.should_receive(:update_attributes).with(params)
      put :update, :id => expense_id, :expense => params
    end

    #it "assigns a flash message" do
    #  put :update, :id => expense_id, :expense => params
    #  flash[:notice].should_not be_nil
    #end

    #it "redirects to the expenses index page" do
    #  put :update, :id => expense_id, :expense => params
    #  response.should redirect_to(:action => "index")
    #end
  end
end
