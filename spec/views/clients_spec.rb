require "spec_helper"

describe "clients/index" do
  let(:client)   { mock_model(Client) }
  let(:clients)  { [client] }
  let(:nickname) { "Acme" }
  let(:name)     { "Acme Inc." }

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
    rendered.should have_tag("td", :with => {:class => "nickname"}, :text => /#{nickname}/i)
  end

  it "gets the names of the clients" do
    clients.each do |c|
      c.should_receive(:name)
    end
    render
  end

  it "shows the names of the clients" do
    render
    rendered.should have_tag("td", :with => {:class => "name"}, :text => /#{name}/i)
  end

  it "shows an edit link for the clients" do
    render
    rendered.should have_selector("a#edit_client_#{client.id}")
  end
end

describe "clients/new" do
  let(:client) { mock_model(Client) }

  before :each do
    client.stub(:nickname => nil, :name => nil, :street => nil, :postcode => nil, :city => nil, :country => nil, :vat_number => nil)
    assign :client, client
  end

  it "has a title" do
    render
    rendered.should have_content("New client")
  end

  it "has a label for the nickname field" do
    render
    rendered.should have_content("Nickname")
  end

  it "has a nickname text field" do
    render
    rendered.should have_selector("#client_nickname")
  end

  it "has a label for the name field" do
    render
    rendered.should have_content("Name")
  end

  it "has a name text field" do
    render
    rendered.should have_selector("#client_name")
  end

  it "has a label for the street field" do
    render
    rendered.should have_content("Street")
  end

  it "has a street text field" do
    render
    rendered.should have_selector("#client_street")
  end

  it "has a label for the postcode field" do
    render
    rendered.should have_content("Postcode")
  end

  it "has a postcode text field" do
    render
    rendered.should have_selector("#client_postcode")
  end

  it "has a label for the city field" do
    render
    rendered.should have_content("City")
  end

  it "has a city text field" do
    render
    rendered.should have_selector("#client_city")
  end

  it "has a label for the country field" do
    render
    rendered.should have_content("Country")
  end

  it "has a country text field" do
    render
    rendered.should have_selector("#client_country")
  end

  it "has a label for the VAT number field" do
    render
    rendered.should have_content("VAT number")
  end

  it "has a VAT number text field" do
    render
    rendered.should have_selector("#client_vat_number")
  end

  it "has a submit button" do
    render
    rendered.should have_button("Add client")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end

describe "clients/edit" do
  let(:client) { mock_model(Client) }

  before :each do
    client.stub(:nickname => nil, :name => nil, :street => nil, :postcode => nil, :city => nil, :country => nil, :vat_number => nil)
    assign :client, client
  end

  it "has a title" do
    render
    rendered.should have_content("Edit client")
  end

  it "has a label for the nickname field" do
    render
    rendered.should have_content("Nickname")
  end

  it "has a nickname text field for the client" do
    render
    rendered.should have_selector("#client_nickname")
  end

  it "has a label for the name field" do
    render
    rendered.should have_content("Name")
  end

  it "has a name text field for the client" do
    render
    rendered.should have_selector("#client_name")
  end

  it "has a label for the street field" do
    render
    rendered.should have_content("Street")
  end

  it "has a street text field for the client" do
    render
    rendered.should have_selector("#client_street")
  end

  it "has a label for the postcode field" do
    render
    rendered.should have_content("Postcode")
  end

  it "has a postcode text field for the client" do
    render
    rendered.should have_selector("#client_postcode")
  end

  it "has a label for the city field" do
    render
    rendered.should have_content("City")
  end

  it "has a city text field" do
    render
    rendered.should have_selector("#client_city")
  end

  it "has a label for the country field" do
    render
    rendered.should have_content("Country")
  end

  it "has a country text field for the client" do
    render
    rendered.should have_selector("#client_country")
  end

  it "has a label for the VAT number field" do
    render
    rendered.should have_content("VAT number")
  end

  it "has a VAT number text field" do
    render
    rendered.should have_selector("#client_vat_number")
  end

  it "has a submit button to update the client" do
    render
    rendered.should have_button("Update client")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
