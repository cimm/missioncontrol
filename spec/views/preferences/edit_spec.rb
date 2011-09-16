require "spec_helper"

describe "preferences/edit" do
  let(:preference) { mock_model(Preference) }
  let(:form)       { mock("Form") }

  before :each do
    stub_template("preferences/_form" => "")
    assign :preference, preference
  end

  it "has a title" do
    render
    rendered.should have_content("Edit preference")
  end

  it "has an edit form" do
    render
    rendered.should have_form(preference_path(preference), "post")
  end

  it "renders the form partial" do
    render
    view.should render_template(:partial => "_form", :object => form)
  end

  it "has a submit button" do
    render
    rendered.should have_button("Update preference")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
