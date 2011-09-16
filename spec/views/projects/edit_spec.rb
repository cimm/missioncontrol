require "spec_helper"

describe "projects/edit" do
  let(:project)      { mock_model(Project) }
  let(:form)         { mock("Form") }

  before :each do
    stub_template("projects/_form" => "")
    assign :project, project
  end

  it "has a title" do
    render
    rendered.should have_content("Edit project")
  end

  it "has an edit form" do
    render
    rendered.should have_form(project_path(project), "post")
  end

  it "renders the form partial" do
    render
    view.should render_template(:partial => "_form", :object => form)
  end

  it "has a submit button" do
    render
    rendered.should have_button("Update project")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
