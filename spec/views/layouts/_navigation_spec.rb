require "spec_helper"

describe "layouts/_navigation" do
  before :each do
    view.stub(:active => "active")
  end

  it "links the title to the root path" do
    render
    rendered.should have_tag("a", :with => {:href => root_path}, :text => "Mission Control")
  end

  it "links to the units index page" do
    render
    rendered.should have_tag("a", :with => {:href => units_path}, :text => "Units")
  end

  it "links to the projects index page" do
    render
    rendered.should have_tag("a", :with => {:href => projects_path}, :text => "Projects")
  end

  it "links to the clients index page" do
    render
    rendered.should have_tag("a", :with => {:href => clients_path}, :text => "Clients")
  end

  it "links to the preferences index page" do
    render
    rendered.should have_tag("a", :with => {:href => preferences_path}, :text => "Preferences")
  end

  it "has an active navigation item" do
    render
    rendered.should have_css(".active")
  end
end
