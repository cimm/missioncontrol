require "spec_helper"

describe ClientsController do
  let(:client) { mock("Client") }

  before :each do
    Client.stub(:new => client)
  end

  describe "index" do
    let(:clients) { mock("All clients") }

    before :each do
      Client.stub(:all => clients)
    end

    it "gets all the clients" do
      Client.should_receive(:all)
      get :index
    end

    it "assigns all the clients" do
      get :index
      assigns(:clients).should eql clients
    end

    it "renders the clients page" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "new" do
    it "creates a new client" do
      Client.should_receive(:new)
      get :new
    end

    it "assigns the client" do
      get :new
      assigns(:client).should eql client
    end

    it "renders the new client page" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "create" do
    let(:params) { {} }

    before :each do
      client.stub(:save)
    end

    it "builds a new client" do
      Client.should_receive(:new).with(params)
      post :create, :client => params
    end

    it "assigns the client" do
      post :create, :client => params
      assigns(:client).should eql client
    end

    it "tries to persist the client" do
      client.should_receive(:save)
      post :create, :client => params
    end

    context "is valid" do
      before :each do
        client.stub(:save => true)
      end

      it "assigns a flash message" do
        post :create, :client => params
        flash[:notice].should_not be_nil
      end

      it "redirects to the clients index page" do
        post :create, :client => params
        response.should redirect_to(:action => "index")
      end
    end

    context "is not valid" do
      before :each do
        client.stub(:save => false)
      end

      it "assigns a non-sticky error flash message" do
        post :create, :client => params
        flash.now[:error].should_not be_nil
        # TODO Isn't testing the "stickyness" at the moment
      end

      it "renders the new page" do
        post :create, :client => params
        response.should render_template(:new)
      end
    end
  end

  describe "edit" do
    let(:client_id) { "Id for the edited client" }

    before :each do
      Client.stub(:find => client)
    end

    it "gets the client to edit" do
      Client.should_receive(:find).with(client_id)
      get :edit, :id => client_id
    end

    it "assigns the client" do
      get :edit, :id => client_id
      assigns(:client).should eql client
    end

    it "renders the edit page" do
      get :edit, :id => client_id
      response.should render_template(:edit)
    end
  end

  describe "update" do
    let(:client_id) { "Id for the updated client" }
    let(:params)    { {} }

    before :each do
      Client.stub(:find => client)
      client.stub(:update_attributes)
    end

    it "gets the client to update" do
      Client.should_receive(:find).with(client_id)
      put :update, :id => client_id, :client => params
    end

    it "updates and persists the client" do
      client.should_receive(:update_attributes).with(params)
      put :update, :id => client_id, :client => params
    end

    it "assigns a flash message" do
      put :update, :id => client_id, :client => params
      flash[:notice].should_not be_nil
    end

    it "redirects to the clients index page" do
      put :update, :id => client_id, :client => params
      response.should redirect_to(:action => "index")
    end
  end
end
