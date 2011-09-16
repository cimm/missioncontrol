require "spec_helper"

describe "projects/_form" do
  let(:project)        { mock_model(Project) }
  let(:client)         { mock_model(Client)}
  let(:clients)        { [client] }
  let(:nickname)       { "Acme" }
  let(:default_rate)   { 400 }
  let(:partial_render) { render :partial => "projects/form", :object => @form }

  before :each do
    project.stub(:name => nil, :client_id => nil, :default_rate => default_rate)
    client.stub(:nickname => nickname)
    assign :clients, clients
    form_for(project) { |f| @form = f }
  end

  it "has a label for the name field" do
    partial_render
    rendered.should have_content("Name")
  end

  it "has a name text field" do
    partial_render
    rendered.should have_selector("#project_name")
  end

  it "has a label for the client field" do
    partial_render
    rendered.should have_content("Client")
  end

  it "has a client select field" do
    partial_render
    rendered.should have_tag("select#project_client_id") do
      with_option nickname, :value => client.id
    end
  end

  it "has a label for the default rate field" do
    partial_render
    rendered.should have_content("Default rate")
  end

  it "has a default rate field" do
    partial_render
    rendered.should have_selector("#project_default_rate")
  end
end
