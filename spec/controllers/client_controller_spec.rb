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
      client.stub(:save!)
    end

    it "creates a new client" do
      Client.should_receive(:new).with(params)
      post :create, :client => params
    end

    it "persists the client" do
      client.should_receive(:save!)
      post :create, :client => params
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
end
