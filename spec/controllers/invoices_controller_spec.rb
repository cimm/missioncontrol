require "spec_helper"

describe InvoicesController do
  let(:invoice) { mock("Invoice") }

  before :each do
    Invoice.stub(:new => invoice)
  end

  describe "index" do
    let(:invoices) { mock("All invoices") }

    before :each do
      Invoice.stub(:all => invoices)
    end

    it "gets all the invoices" do
      Invoice.should_receive(:all)
      get :index
    end

    it "assigns all the invoices" do
      get :index
      assigns(:invoices).should eql invoices
    end

    it "renders the invoices page" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "new" do
    let(:next_number)      { mock("Next number") }
    let(:selectable_units) { mock("Selectable units") }

    before :each do
      Invoice.stub(:next_number => next_number)
      invoice.stub(:number= => nil, :selectable_units => selectable_units)
    end

    it "builds a new invoice" do
      Invoice.should_receive(:new)
      get :new
    end

    it "assigns a new invoice" do
      get :new
      assigns(:invoice).should eql invoice
    end

    it "gets the next number" do
      Invoice.should_receive(:next_number)
      get :new
    end

    it "adds the next number to the invoice" do
      invoice.should_receive(:number=).with(next_number)
      get :new
    end

    it "gets the selectable units to choose from" do
      invoice.should_receive(:selectable_units)
      get :new
    end

    it "assigns the selectable units to choose from" do
      get :new
      assigns(:selectable_units).should eql selectable_units
    end

    it "renders the new invoice page" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "create" do
    let(:params) { {} }

    before :each do
      invoice.stub(:save)
    end

    it "builds a new invoice" do
      Invoice.should_receive(:new).with(params)
      post :create, :invoice => params
    end

    it "tries to persist the invoice" do
      invoice.should_receive(:save)
      post :create, :invoice => params
    end

    context "is valid" do
      before :each do
        invoice.stub(:save => true)
      end

      it "assigns a flash message" do
        post :create, :invoice => params
        flash[:notice].should_not be_nil
      end
    end

    context "is not valid" do
      before :each do
        invoice.stub(:save => false)
      end

      it "assigns an error flash message" do
        post :create, :invoice => params
        flash[:error].should_not be_nil
      end
    end

    it "redirects to the invoices index page" do
      post :create, :invoice => params
      response.should redirect_to(:action => "index")
    end
  end

  describe "edit" do
    let(:invoice_id)       { "Id for the edited invoice" }
    let(:selectable_units) { mock("Units that aren't invoiced or linked to the current invoice") }

    before :each do
      Invoice.stub(:find => invoice)
      invoice.stub(:selectable_units => selectable_units)
    end

    it "gets the invoice to edit" do
      Invoice.should_receive(:find).with(invoice_id)
      get :edit, :id => invoice_id
    end

    it "assigns the invoice" do
      get :edit, :id => invoice_id
      assigns(:invoice).should eql invoice
    end

    it "gets the selectable units" do
      invoice.should_receive(:selectable_units)
      get :edit, :id => invoice_id
    end

    it "assigns the selectable units" do
      get :edit, :id => invoice_id
      assigns(:selectable_units).should eql selectable_units
    end

    it "renders the edit page" do
      get :edit, :id => invoice_id
      response.should render_template(:edit)
    end
  end

  describe "update" do
    let(:invoice_id) { "Id for the updated invoice" }
    let(:params)     { {} }

    before :each do
      Invoice.stub(:find => invoice)
      invoice.stub(:update_attributes)
    end

    it "gets the invoice to update" do
      Invoice.should_receive(:find).with(invoice_id)
      put :update, :id => invoice_id, :invoice => params
    end

    it "updates and persists the invoice" do
      invoice.should_receive(:update_attributes).with(params)
      put :update, :id => invoice_id, :invoice => params
    end

    it "assigns a flash message" do
      put :update, :id => invoice_id, :invoice => params
      flash[:notice].should_not be_nil
    end

    it "redirects to the invoices index page" do
      put :update, :id => invoice_id, :invoice => params
      response.should redirect_to(:action => "index")
    end
  end
end
