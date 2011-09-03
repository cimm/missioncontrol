require "spec_helper"

describe "projects/index" do
  let(:project)  { mock_model(Project) }
  let(:projects) { [project] }
  let(:name)     { "Project Stradivarius" }

  before :each do
    project.stub(:name => name)
    assign :projects, projects
  end

  it "has a title" do
    render
    rendered.should have_content("Projects")
  end

  it "has a link to create a new client" do
    render
    rendered.should have_link("New")
  end

  it "shows the projects names" do
    render
    rendered.should have_tag("td", :with => {:class => "name"}, :text => /#{name}/i)
  end

  it "shows an edit link for the projects" do
    render
    projects.each do |p|
      rendered.should have_selector("a#edit_project_#{p.id}")
    end
  end

end

describe "projects/new" do
  let(:project)  { mock_model(Project) }
  let(:client)   { mock_model(Client)}
  let(:nickname) { "Acme" }
  let(:clients)  { [client] }

  before :each do
    project.stub(:name => nil, :client_id => client)
    client.stub(:nickname => nickname)
    assign :project, project
    assign :client,  client
    assign :clients, clients
  end

  it "has a title" do
    render
    rendered.should have_content("New project")
  end

  it "has a label for the name field" do
    render
    rendered.should have_content("Name")
  end

  it "has a name text field" do
    render
    rendered.should have_selector("#project_name")
  end

  it "has a label for the client field" do
    render
    rendered.should have_content("Client")
  end

  it "has a client select field" do
    render
    rendered.should have_tag("select", :with => {:id => "project_client_id"}) do
      with_tag "option", :with => {:value => client.id}, :text => /#{nickname}/i
    end
  end

  it "has a submit button" do
    render
    rendered.should have_button("Add project")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end

describe "projects/edit" do
  let(:project)  { mock_model(Project) }
  let(:client)   { mock_model(Client)}
  let(:nickname) { "Acme" }
  let(:clients)  { [client] }

  before :each do
    project.stub(:name => nil, :client_id => client)
    client.stub(:nickname => nickname)
    assign :project, project
    assign :client,  client
    assign :clients, clients
  end

  it "has a title" do
    render
    rendered.should have_content("Edit project")
  end

  it "has a label for the name field" do
    render
    rendered.should have_content("Name")
  end

  it "has a name text field for the project" do
    render
    rendered.should have_selector("#project_name")
  end

  it "has a submit button to update the project" do
    render
    rendered.should have_button("Update project")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
