require "spec_helper"

describe UnitsController do
  let(:unit) { mock("Unit") }

  before :each do
    Unit.stub(:new => unit)
  end

  describe "index" do
    let(:units)       { mock("All units") }
    let(:projects)    { [mock("Project")] }
    let(:total_units) { mock("Total number of units")}

    before :each do
      Unit.stub(:all => units)
      units.stub(:count => total_units)
      Project.stub(:all => projects)
    end

    it "creates a new unit" do
      Unit.should_receive(:new)
      get :index
    end

    it "assigns a new unit" do
      get :index
      assigns(:unit).should eql unit
    end

    it "gets all the units" do
      Unit.should_receive(:all)
      get :index
    end

    it "assigns all the units" do
      get :index
      assigns(:units).should eql units
    end

    it "gets all the projects" do
      Project.should_receive(:all)
      get :index
    end

    it "assigns all the projects" do
      get :index
      assigns(:projects).should eql projects
    end

    it "gets the total number of units" do
      units.should_receive(:count)
      get :index
    end

    it "assgins the total number of units" do
      get :index
      assigns(:total_units).should eql total_units
    end

    it "renders the units page" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "create" do
    let(:params) { {} }

    before :each do
      unit.stub(:save)
    end

    it "builds a new unit" do
      Unit.should_receive(:new).with(params)
      post :create, :unit => params
    end

    it "tries to persist the unit" do
      unit.should_receive(:save)
      post :create, :unit => params
    end

    context "is valid" do
      before :each do
        unit.stub(:save => true)
      end

      it "assigns a flash message" do
        post :create, :unit => params
        flash[:notice].should_not be_nil
      end
    end

    context "is not valid" do
      before :each do
        unit.stub(:save => false)
      end

      it "assigns an error flash message" do
        post :create, :unit => params
        flash[:error].should_not be_nil
      end
    end

    it "redirects to the units index page" do
      post :create, :unit => params
      response.should redirect_to(:action => "index")
    end
  end

  describe "edit" do
    let(:unit_id)  { "Id for the edited unit" }
    let(:projects) { [mock("Project")] }

    before :each do
      Unit.stub(:find => unit)
      Project.stub(:all => projects)
    end

    it "gets the unit to edit" do
      Unit.should_receive(:find).with(unit_id)
      get :edit, :id => unit_id
    end

    it "assigns the unit" do
      get :edit, :id => unit_id
      assigns(:unit).should eql unit
    end

    it "gets all the projects" do
      Project.should_receive(:all)
      get :edit, :id => unit_id
    end

    it "assigns all the projects" do
      get :edit, :id => unit_id
      assigns(:projects).should eql projects
    end

    it "renders the edit page" do
      get :edit, :id => unit_id
      response.should render_template(:edit)
    end
  end

  describe "update" do
    let(:unit_id) { "Id for the updated unit" }
    let(:params)  { {} }

    before :each do
      Unit.stub(:find => unit)
      unit.stub(:update_attributes)
    end

    it "gets the unit to update" do
      Unit.should_receive(:find).with(unit_id)
      put :update, :id => unit_id, :unit => params
    end

    it "updates and persists the unit" do
      unit.should_receive(:update_attributes).with(params)
      put :update, :id => unit_id, :unit => params
    end

    it "assigns a flash message" do
      put :update, :id => unit_id, :unit => params
      flash[:notice].should_not be_nil
    end

    it "redirects to the units index page" do
      put :update, :id => unit_id, :unit => params
      response.should redirect_to(:action => "index")
    end
  end
end
