require "spec_helper"

describe UnitsController do
  let(:unit) { mock("Unit") }

  before :each do
    Unit.stub(:new => unit)
  end

  describe "index" do
    let(:total_units) { mock("Total number of units")}

    before :each do
      Unit.stub(:count => total_units)
    end

    it "creates a new unit" do
      Unit.should_receive(:new)
      get :index
    end

    it "assigns a new unit" do
      get :index
      assigns(:unit).should eql unit
    end

    it "gets the total number of units" do
      Unit.should_receive(:count)
      get :index
    end

    it "assgins the total number of units" do
      get :index
      assigns(:total_units).should eql total_units
    end

    it "shows the units page" do
      get :index
      response.should be_success
    end
  end

  describe "create" do
    before :each do
      unit.stub(:save!)
    end

    it "creates a new unit" do
      Unit.should_receive(:new)
      post :create
    end

    it "persists the unit" do
      unit.should_receive(:save!)
      post :create
    end

    it "assigns a flash message" do
      post :create
      flash[:notice].should_not be_nil
    end

    it "redirects to the units show page" do
      post :create
      response.should redirect_to(:action => "index")
    end
  end
end
