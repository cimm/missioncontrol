# encoding: UTF-8
require "spec_helper"

describe "projects/index" do
  let(:project)      { mock_model(Project) }
  let(:projects)     { [project] }
  let(:name)         { "Project Stradivarius" }
  let(:client)       { mock_model(Client) }
  let(:nickname)     { "Acme" }
  let(:default_rate) { 400 }

  before :each do
    project.stub(:name => name, :client_nickname => nickname, :default_rate => default_rate)
    client.stub(:nickname => nickname)
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

  it "gets the names from the projects" do
    projects.each do |p|
      p.should_receive(:name)
    end
    render
  end

  it "shows the projects names" do
    render
    rendered.should have_tag(".name", :text => name)
  end

  it "gets the clients' nicknames from the projects" do
    projects.each do |p|
      p.should_receive(:client_nickname)
    end
    render
  end

  it "shows the client nicknames" do
    render
    rendered.should have_tag(".nickname", :text => nickname)
  end

  it "gets the default rates from the projects" do
    projects.each do |p|
      p.should_receive(:default_rate)
    end
    render
  end

  context "has a default rate" do
    it "shows the default rates" do
      render
      rendered.should have_tag(".default_rate", :text => /€\s#{default_rate}/)
    end
  end

  context "has no default rate" do
    before :each do
      project.stub(:default_rate => nil)
    end

    it "shows the default rates" do
      render
      rendered.should have_tag(".default_rate", :text => /\s/)
    end
  end

  it "shows an edit link for the projects" do
    render
    projects.each do |p|
      rendered.should have_selector("a#edit_project_#{p.id}")
    end
  end

end
