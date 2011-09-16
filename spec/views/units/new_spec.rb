require "spec_helper"

describe "units/new" do
  let(:unit)     { mock_model(Unit) }
  let(:form)     { mock("Form") }

  before :each do
    stub_template("units/_form" => "")
    assign :unit,     unit
  end

  it "has a title" do
    render
    rendered.should have_content("New unit")
  end

  it "has a new form" do
    render
    rendered.should have_form(unit_path(unit), "post")
  end

  it "renders the form partial" do
    render
    view.should render_template(:partial => "_form", :object => form)
  end

  it "has a submit button" do
    render
    rendered.should have_button("Add unit")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
