require "spec_helper"

describe ClientsController do
  let(:client) { mock("Client") }

  before :each do
    Client.stub(:new => client)
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
