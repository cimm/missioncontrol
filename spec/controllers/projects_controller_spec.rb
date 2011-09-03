require "spec_helper"

describe ProjectsController do
  let(:project) { mock("Project") }

  before :each do
    Project.stub(:new => project)
  end

  describe "index" do
    let(:projects) { mock("All projects") }

    before :each do
      Project.stub(:all => projects)
    end

    it "gets all the projects" do
      Project.should_receive(:all)
      get :index
    end

    it "assigns all the projects" do
      get :index
      assigns(:projects).should eql projects
    end

    it "renders the projects page" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "new" do
    let(:client)  { mock("Client") }
    let(:clients) { [client] }

    before :each do
      Client.stub(:all => clients)
    end

    it "creates a new project" do
      Project.should_receive(:new)
      get :new
    end

    it "assigns the project" do
      get :new
      assigns(:project).should eql project
    end

    it "gets all the clients" do
      Client.should_receive(:all)
      get :new
    end

    it "assigns all the clients" do
      get :new
      assigns(:clients).should eql clients
    end

    it "renders the new project page" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "create" do
    let(:params) { {} }

    before :each do
      project.stub(:save)
    end

    it "builds a new project" do
      Project.should_receive(:new).with(params)
      post :create, :project => params
    end

    it "assigns the project" do
      post :create, :project => params
      assigns(:project).should eql project
    end

    it "tries to persist the project" do
      project.should_receive(:save)
      post :create, :project => params
    end

    context "is valid" do
      before :each do
        project.stub(:save => true)
      end

      it "assigns a flash message" do
        post :create, :project => params
        flash[:notice].should_not be_nil
      end

      it "redirects to the projects index page" do
        post :create, :project => params
        response.should redirect_to(:action => "index")
      end
    end

    context "is not valid" do
      before :each do
        project.stub(:save => false)
      end

      it "assigns a non-sticky error flash message" do
        post :create, :project => params
        flash.now[:error].should_not be_nil
        # TODO Isn't testing the "stickyness" at the moment
      end

      it "renders the new page" do
        post :create, :project => params
        response.should render_template(:new)
      end
    end
  end

  describe "edit" do
    let(:project_id) { "Id for the edited project" }
    let(:client)     { mock("Client") }
    let(:clients)    { [client] }

    before :each do
      Client.stub(:all => clients)
    end

    before :each do
      Project.stub(:find => project)
    end

    it "gets the project to edit" do
      Project.should_receive(:find).with(project_id)
      get :edit, :id => project_id
    end

    it "assigns the project" do
      get :edit, :id => project_id
      assigns(:project).should eql project
    end

    it "gets all the clients" do
      Client.should_receive(:all)
      get :edit, :id => project_id
    end

    it "assigns all the clients" do
      get :edit, :id => project_id
      assigns(:clients).should eql clients
    end

    it "renders the edit page" do
      get :edit, :id => project_id
      response.should render_template(:edit)
    end
  end

  describe "update" do
    let(:project_id) { "Id for the updated project" }
    let(:params)     { {} }

    before :each do
      Project.stub(:find => project)
      project.stub(:update_attributes)
    end

    it "gets the project to update" do
      Project.should_receive(:find).with(project_id)
      put :update, :id => project_id, :project => params
    end

    it "updates and persists the project" do
      project.should_receive(:update_attributes).with(params)
      put :update, :id => project_id, :project => params
    end

    it "assigns a flash message" do
      put :update, :id => project_id, :project => params
      flash[:notice].should_not be_nil
    end

    it "redirects to the projects index page" do
      put :update, :id => project_id, :project => params
      response.should redirect_to(:action => "index")
    end
  end
end
