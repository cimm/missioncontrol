require "spec_helper"

describe "clients/index" do
  let(:client)   { mock_model(Client) }
  let(:clients)  { [client] }
  let(:nickname) { mock("Client's nicknane") }

  before :each do
    client.stub(:nickname => nickname)
    assign :clients, clients
  end

  it "has a title" do
    render
    rendered.should have_content("Clients")
  end

  it "shows the nicknames of the clients" do
    render
    rendered.should have_content(nickname)
  end
end

describe "clients/new" do
  let(:client) { mock_model(Client) }

  before :each do
    client.stub(:nickname)
    assign :client, client
  end

  it "has a title" do
    render
    rendered.should have_content("New client")
  end

  it "has a nickname field" do
    render
    rendered.should have_selector("#client_nickname")
  end

  it "has a submit button" do
    render
    rendered.should have_button("Add client")
  end
end
