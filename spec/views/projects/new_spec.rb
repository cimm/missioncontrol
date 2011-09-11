require "spec_helper"

describe "projects/new" do
  let(:project)      { mock_model(Project) }
  let(:form)         { mock("Form") }

  before :each do
    stub_template("projects/_form" => "")
    assign :project, project
  end

  it "has a title" do
    render
    rendered.should have_content("New project")
  end

  it "renders the form partial" do
    render
    view.should render_template(:partial => "_form", :object => form)
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
