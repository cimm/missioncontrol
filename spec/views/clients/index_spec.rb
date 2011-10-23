require "spec_helper"

describe "clients/index" do
  let(:client)   { mock_model(Client) }
  let(:clients)  { [client] }
  let(:nickname) { mock("Company nickname") }
  let(:name)     { mock("Company name") }

  before :each do
    client.stub(:nickname => nickname, :name => name)
    assign :clients, clients
  end

  it "has a title" do
    render
    rendered.should have_content("Clients")
  end

  it "has a link to create a new client" do
    render
    rendered.should have_link("New")
  end

  it "gets the nicknames of the clients" do
    clients.each do |c|
      c.should_receive(:nickname)
    end
    render
  end

  it "shows the nicknames of the clients" do
    render
    rendered.should have_tag(".nickname", :text => nickname)
  end

  it "gets the names of the clients" do
    clients.each do |c|
      c.should_receive(:name)
    end
    render
  end

  it "shows the names of the clients" do
    render
    rendered.should have_tag(".name", :text => name)
  end

  it "shows an edit link for the clients" do
    render
    rendered.should have_selector("a#edit_client_#{client.id}")
  end
end
